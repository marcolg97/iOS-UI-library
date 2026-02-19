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

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isVisible {
                    BackgroundStatusBarView(style: style)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: isVisible)
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
/// Use to indicate app-wide status (e.g. offline, warning) without business logic or navigation. All visual tokens are injected via style.
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
        Spacer(minLength: 0)
            .frame(maxWidth: .infinity)
            .frame(height: style.height)
            .background(style.backgroundColor)
            .ignoresSafeArea(edges: .top)
    }
}

#if DEBUG
struct OfflineBannerTestView: View {

    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink(.pushDetail) {
                    DetailView()
                }

                Button(isOffline ? .goOnline : .goOffline) {
                    isOffline.toggle()
                }
            }
            .navigationTitle(.home)
        }
        .backgroundStatusBar(
            isVisible: isOffline,
            style: .warning
        )
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text(.detailScreen)
        }
        .navigationTitle(.detail)
    }
}

// MARK: - Preview

#Preview {
    OfflineBannerTestView()
}
#endif
