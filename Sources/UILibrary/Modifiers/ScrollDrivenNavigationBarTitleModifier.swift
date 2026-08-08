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

/// A view modifier that reveals the navigation bar title after scrolling past a threshold.
///
/// This modifier tracks scroll position and shows the navigation bar title with a fade animation
/// once the user scrolls beyond a specified distance. It's particularly useful for screens with
/// large headers where you want to conserve space initially but provide context after scrolling.
///
/// ## Implementation
/// - iOS 18+: Uses SwiftUI's native `.onScrollGeometryChange` for optimal performance
/// - iOS 17: Reads the preference emitted by `scrollDrivenNavigationBarTitleTracking()`,
///   which must be attached to the content *inside* the ScrollView
///
/// The navigation bar background automatically hides when scrolled to the top.
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

    private var shouldShowNavigationBarTitle: Bool {
        scrollDelta > max(0, revealAfter)
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
    private func ios18Implementation(content: Content) -> some View {
        content
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                // Return the content offset Y (positive when scrolling down)
                geometry.contentOffset.y
            } action: { _, newValue in
                updateOffset(newValue)
            }
            .applyNavigationBarTitle(
                title: title,
                shouldShow: shouldShowNavigationBarTitle,
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
            .applyNavigationBarTitle(
                title: title,
                shouldShow: shouldShowNavigationBarTitle,
                animationDuration: animationDuration,
                reduceMotion: reduceMotion
            )
    }
}

/// Helper extension to apply navigation bar title styling
private extension View {
    func applyNavigationBarTitle(
        title: LocalizedStringResource,
        shouldShow: Bool,
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
                        .opacity(shouldShow ? 1 : 0)
                        .animation(
                            reduceMotion ? .none : .easeInOut(duration: animationDuration),
                            value: shouldShow
                        )
                }
            }
#if os(iOS) || targetEnvironment(macCatalyst)
            .toolbarBackground(shouldShow ? .visible : .hidden, for: .navigationBar)
#endif
    }
}

public extension View {
    /// Shows the navigation bar title only after scrolling past a threshold.
    ///
    /// Automatically uses the best available API for the iOS version:
    /// - iOS 18+: Uses `.onScrollGeometryChange` for optimal performance
    /// - iOS 17: Reads the scroll offset published by
    ///   `scrollDrivenNavigationBarTitleTracking()` (see below)
    ///
    /// The title fades in smoothly once the user scrolls beyond the specified threshold,
    /// and the navigation bar background becomes visible. When scrolled back to the top,
    /// the title and background automatically hide.
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
    ///   - Navigation bar background hides when scrolled to top
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

    /// Publishes the scroll offset of the view it is attached to, for consumption by
    /// `scrollDrivenNavigationBarTitle(_:revealAfter:animationDuration:)` on iOS 17.
    ///
    /// Attach this to the content **inside** the ScrollView (it measures the content's
    /// position in global coordinates, so no named coordinate space is required):
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
            }
        )
    }
}
