//
//  ScrollDrivenNavigationBarTitleModifier.swift
//  UILibrary
//
//  Created by Marco La Gala on 04/02/26.
//

import SwiftUI

/// A preference key to track scroll position for iOS 17 compatibility
private struct ScrollOffsetPreferenceKey: PreferenceKey {
    nonisolated static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// A preference key to track the scrollable content's height for iOS 17 compatibility.
private struct ScrollContentHeightPreferenceKey: PreferenceKey {
    nonisolated static let defaultValue: CGFloat = .infinity
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// A preference key to track the scroll view's own (viewport) height for iOS 17 compatibility.
private struct ScrollViewportHeightPreferenceKey: PreferenceKey {
    nonisolated static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// A view modifier that reveals the navigation bar title after scrolling past a threshold.
///
/// This modifier tracks scroll position and shows the navigation bar title with a fade
/// once the user scrolls beyond a specified distance. It's particularly useful for screens with
/// large headers where you want to conserve space initially but provide context after scrolling.
///
/// ## Implementation
/// - iOS 18+: Uses SwiftUI's native `.onScrollGeometryChange` for optimal performance, reading
///   both the scroll offset and the content/viewport sizes straight from `ScrollGeometry`.
/// - iOS 17: Reads the preferences emitted by `scrollDrivenNavigationBarTitleTracking()`,
///   which must be attached to the content *inside* the ScrollView, plus the viewport size
///   measured on the scroll view itself.
///
/// The navigation bar background automatically hides when the title is fully hidden.
///
/// ## Non-scrollable content
/// When the content is shorter than the scroll view's viewport — so the user can never scroll
/// past `revealAfter` — the title is shown at full opacity immediately instead of staying
/// permanently invisible. This is what `titleOpacity(scrollOffset:contentHeight:viewportHeight:threshold:)`
/// encodes: it is a pure function of the current measurements, so it is deterministic and unit-testable
/// without a running UI.
///
/// ## Usage
/// ```swift
/// ScrollView {
///     // Your content
/// }
/// .scrollDrivenNavigationBarTitle("Settings", revealAfter: 50)
/// ```
///
/// - Note: Works with ScrollView, List, and Form containers. Minimum iOS 17.0.
@MainActor
public struct ScrollDrivenNavigationBarTitleModifier: ViewModifier {
    /// The localized title to display in the navigation bar
    private let title: LocalizedStringResource

    /// The scroll distance threshold (in points) that must be exceeded before showing the title
    private let revealAfter: CGFloat

    /// The duration of the fade animation when showing/hiding the title
    private let animationDuration: Double

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// The current vertical scroll offset from the top
    @State private var scrollOffset: CGFloat = 0

    /// The initial scroll offset captured when the view first appears
    @State private var initialScrollOffset: CGFloat?

    /// The measured height of the scrollable content. Defaults to `.infinity` so that, before the
    /// first real measurement arrives, the modifier behaves exactly like before (offset-driven
    /// fade) instead of momentarily assuming the content isn't scrollable.
    @State private var contentHeight: CGFloat = .infinity

    /// The measured height of the scroll view's own viewport (visible bounds).
    @State private var viewportHeight: CGFloat = 0

    /// Creates the modifier. Prefer the `scrollDrivenNavigationBarTitle(_:revealAfter:animationDuration:)`
    /// view extension over instantiating this type directly.
    public init(
        title: LocalizedStringResource,
        revealAfter: CGFloat,
        animationDuration: Double = 0.18
    ) {
        self.title = title
        self.revealAfter = revealAfter
        self.animationDuration = animationDuration
    }

    /// The scroll delta from the initial position
    private var scrollDelta: CGFloat {
        guard let initialScrollOffset else { return 0 }
        return scrollOffset - initialScrollOffset
    }

    /// The current navigation bar title opacity, derived from scroll offset and content/viewport
    /// measurements. See `titleOpacity(scrollOffset:contentHeight:viewportHeight:threshold:)`.
    private var titleOpacity: Double {
        Self.titleOpacity(
            scrollOffset: scrollDelta,
            contentHeight: contentHeight,
            viewportHeight: viewportHeight,
            threshold: revealAfter
        )
    }

    /// Pure, deterministic computation of the navigation bar title's opacity.
    ///
    /// - When the content is not taller than the viewport (no scrolling is possible), the title is
    ///   always fully opaque — this is the fix for the bug where short screens left the title
    ///   permanently invisible because `revealAfter` could never be crossed.
    /// - When the content is scrollable, the opacity ramps linearly from `0` at the top of the
    ///   scroll view to `1` once `scrollOffset` reaches `threshold`, and stays at `1` beyond it.
    ///
    /// - Parameters:
    ///   - scrollOffset: The scroll distance from the top (0 at the top; positive when scrolled down).
    ///   - contentHeight: The height of the scrollable content.
    ///   - viewportHeight: The height of the scroll view's visible viewport.
    ///   - threshold: The scroll distance after which the title should be fully visible.
    /// - Returns: A value in `0...1`.
    nonisolated static func titleOpacity(
        scrollOffset: CGFloat,
        contentHeight: CGFloat,
        viewportHeight: CGFloat,
        threshold: CGFloat
    ) -> Double {
        guard contentHeight > viewportHeight else {
            // Content can't scroll past the reveal threshold — show the title immediately.
            return 1
        }

        let clampedThreshold = max(0, threshold)
        guard clampedThreshold > 0 else {
            return scrollOffset > 0 ? 1 : 0
        }

        let progress = Double(scrollOffset / clampedThreshold)
        return min(max(progress, 0), 1)
    }

    public func body(content: Content) -> some View {
        if #available(iOS 18.0, macOS 15.0, *) {
            ios18Implementation(content: content)
        } else {
            ios17Implementation(content: content)
        }
    }

    private func updateOffset(_ newValue: CGFloat) {
        if initialScrollOffset == nil {
            initialScrollOffset = newValue
        }
        scrollOffset = newValue
    }

    @available(iOS 18.0, macOS 15.0, *)
    private struct ScrollMetrics: Equatable {
        var offsetY: CGFloat
        var contentHeight: CGFloat
        var viewportHeight: CGFloat
    }

    @available(iOS 18.0, macOS 15.0, *)
    private func ios18Implementation(content: Content) -> some View {
        content
            .onScrollGeometryChange(for: ScrollMetrics.self) { geometry in
                ScrollMetrics(
                    // Positive when scrolling down.
                    offsetY: geometry.contentOffset.y,
                    contentHeight: geometry.contentSize.height,
                    viewportHeight: geometry.containerSize.height
                )
            } action: { _, newValue in
                updateOffset(newValue.offsetY)
                contentHeight = newValue.contentHeight
                viewportHeight = newValue.viewportHeight
            }
            .applyNavigationBarTitle(
                title: title,
                opacity: titleOpacity,
                animationDuration: animationDuration,
                reduceMotion: reduceMotion
            )
    }

    private func ios17Implementation(content: Content) -> some View {
        content
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                MainActor.assumeIsolated {
                    updateOffset(value)
                }
            }
            .onPreferenceChange(ScrollContentHeightPreferenceKey.self) { value in
                MainActor.assumeIsolated {
                    contentHeight = value
                }
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ScrollViewportHeightPreferenceKey.self, value: proxy.size.height)
                }
            )
            .onPreferenceChange(ScrollViewportHeightPreferenceKey.self) { value in
                MainActor.assumeIsolated {
                    viewportHeight = value
                }
            }
            .applyNavigationBarTitle(
                title: title,
                opacity: titleOpacity,
                animationDuration: animationDuration,
                reduceMotion: reduceMotion
            )
    }
}

/// Helper extension to apply navigation bar title styling
private extension View {
    func applyNavigationBarTitle(
        title: LocalizedStringResource,
        opacity: Double,
        animationDuration: Double,
        reduceMotion: Bool
    ) -> some View {
        self
            .navigationTitle(Text(title))
#if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .opacity(opacity)
                        .animation(
                            reduceMotion ? .none : .easeInOut(duration: animationDuration),
                            value: opacity
                        )
                }
            }
#if os(iOS) || targetEnvironment(macCatalyst)
            .toolbarBackground(opacity > 0 ? .visible : .hidden, for: .navigationBar)
#endif
    }
}

public extension View {
    /// Shows the navigation bar title only after scrolling past a threshold.
    ///
    /// Automatically uses the best available API for the iOS version:
    /// - iOS 18+: Uses `.onScrollGeometryChange` for optimal performance
    /// - iOS 17: Reads the scroll offset and content height published by
    ///   `scrollDrivenNavigationBarTitleTracking()` (see below)
    ///
    /// The title fades in smoothly as the user scrolls towards the threshold, and the navigation
    /// bar background becomes visible together with it. When scrolled back to the top, the title
    /// and background automatically hide.
    ///
    /// If the content is shorter than the scroll view's viewport — so it can never be scrolled far
    /// enough to cross `revealAfter` — the title is shown at full opacity immediately instead of
    /// staying invisible forever.
    ///
    /// - Parameters:
    ///   - title: The localized title to display in the navigation bar
    ///   - revealAfter: The scroll distance (in points) required before revealing the title
    ///   - animationDuration: The fade animation duration in seconds (default: 0.18)
    ///
    /// - Returns: A view with scroll-driven navigation bar title behavior
    ///
    /// ## Usage
    /// **iOS 18+** (Automatic):
    /// ```swift
    /// ScrollView {
    ///     content
    /// }
    /// .scrollDrivenNavigationBarTitle("Settings", revealAfter: 50)
    /// ```
    ///
    /// **iOS 17** (requires the tracking modifier on the scroll *content*):
    /// ```swift
    /// ScrollView {
    ///     content
    ///         .scrollDrivenNavigationBarTitleTracking()
    /// }
    /// .scrollDrivenNavigationBarTitle("Settings", revealAfter: 50)
    /// ```
    ///
    /// - Note:
    ///   - Minimum iOS 17.0
    ///   - Respects `accessibilityReduceMotion` setting
    ///   - Works with ScrollView, List, and Form
    ///   - Navigation bar background hides when the title is hidden
    ///   - Content shorter than the viewport always shows the title at full opacity
    func scrollDrivenNavigationBarTitle(
        _ title: LocalizedStringResource,
        revealAfter: CGFloat,
        animationDuration: Double = 0.18
    ) -> some View {
        modifier(
            ScrollDrivenNavigationBarTitleModifier(
                title: title,
                revealAfter: revealAfter,
                animationDuration: animationDuration
            )
        )
    }

    /// Publishes the scroll offset and content height of the view it is attached to, for
    /// consumption by `scrollDrivenNavigationBarTitle(_:revealAfter:animationDuration:)` on iOS 17.
    ///
    /// Attach this to the content **inside** the ScrollView (it measures the content's
    /// frame in global coordinates, so no named coordinate space is required):
    ///
    /// ```swift
    /// ScrollView {
    ///     VStack { ... }
    ///         .scrollDrivenNavigationBarTitleTracking()
    /// }
    /// .scrollDrivenNavigationBarTitle("Settings", revealAfter: 50)
    /// ```
    ///
    /// On iOS 18+ this modifier is unnecessary (and harmless): the title modifier
    /// uses `.onScrollGeometryChange` instead.
    func scrollDrivenNavigationBarTitleTracking() -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: -geometry.frame(in: .global).minY
                    )
                    .preference(
                        key: ScrollContentHeightPreferenceKey.self,
                        value: geometry.size.height
                    )
            }
        )
    }
}
