//
//  BackgroundStatusBarView.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

struct BackgroundStatusBarOverlay: ViewModifier {
    let isVisible: Bool
    let style: BackgroundStatusBarStyle

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                ZStack(alignment: .top) {
                    if isVisible {
                        BackgroundStatusBarView(style: style)
                            .transition(
                                reduceMotion
                                    ? .opacity
                                    : .move(edge: .top).combined(with: .opacity)
                            )
                    }
                }
                .animation(reduceMotion ? nil : .easeInOut(duration: 0.25), value: isVisible)
            }
    }
}

/// Adds a background status bar overlay to any view.
///
/// **Layer:** Organism
///
/// **Responsibility:**
/// Visually displays a status bar at the top of the screen, styled via `BackgroundStatusBarStyle`.
///
/// **Usage:**
/// Use to indicate app-wide status (e.g. offline, warning) without business logic or navigation.
/// All visual tokens are injected via style.
///
/// The bar is purely decorative (a colored strip with no text), so it is
/// hidden from assistive technologies; announce the underlying state change
/// (e.g. via `AccessibilityNotification.Announcement`) from the app.
///
/// Example:
/// ```swift
/// .backgroundStatusBar(isVisible: isOffline, style: .warning)
/// ```
public extension View {
    /// Adds a background status bar overlay to any view.
    /// - Parameters:
    ///   - isVisible: Whether the status bar is visible.
    ///   - style: Visual style to apply.
    func backgroundStatusBar(
        isVisible: Bool,
        style: BackgroundStatusBarStyle
    ) -> some View {
        modifier(
            BackgroundStatusBarOverlay(
                isVisible: isVisible,
                style: style
            )
        )
    }
}

private struct BackgroundStatusBarView: View {
    let style: BackgroundStatusBarStyle

    var body: some View {
        style.backgroundColor
            .frame(maxWidth: .infinity)
            .frame(height: style.height)
            .ignoresSafeArea(edges: .top)
            .accessibilityHidden(true)
    }
}

#if DEBUG
private struct OfflineBannerTestView: View {

    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink {
                    OfflineBannerDetailPreview()
                } label: {
                    Text(verbatim: "Push detail")
                }

                Button(action: { isOffline.toggle() }) {
                    Text(verbatim: isOffline ? "Go online" : "Go offline")
                }
            }
            .navigationTitle(Text(verbatim: "Home"))
        }
        .backgroundStatusBar(
            isVisible: isOffline,
            style: .warning
        )
    }
}

private struct OfflineBannerDetailPreview: View {
    var body: some View {
        VStack {
            Text(verbatim: "Detail screen")
        }
        .navigationTitle(Text(verbatim: "Detail"))
    }
}

// MARK: - Preview

#Preview("Offline banner — interactive") {
    OfflineBannerTestView()
}
#endif
