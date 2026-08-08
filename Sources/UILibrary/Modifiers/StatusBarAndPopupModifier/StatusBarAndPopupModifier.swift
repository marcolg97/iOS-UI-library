//
//  StatusBarAndPopupModifier.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

/// ViewModifier that displays a top status bar and a bottom toast for an
/// app-wide state (offline, maintenance, restricted access, etc.).
///
/// - Layer: Organism
/// - Responsibility: Present an app-wide visual indicator (top status bar) and a transient
///   bottom toast for critical status. Styling is injected via
///   `BackgroundStatusBarStyle` and the toast content builder.
/// - Usage: Apply to any root view to surface app-wide status UI consistently across screens.
@MainActor
public struct StatusBarAndPopupModifier<PopupContent: View>: ViewModifier {
    /// Generic boolean that controls visibility of the top status bar and bottom toast.
    @Binding private var hasToShow: Bool

    private let popupContent: () -> PopupContent
    private let popupBottomPadding: CGFloat
    private let backgroundStatusBarStyle: BackgroundStatusBarStyle

    /// Creates a `StatusBarAndPopupModifier`.
    /// - Parameters:
    ///   - hasToShow: Binding controlling whether the top status bar / toast is shown.
    ///     Dismissing the toast (drag) writes `false` back to this binding.
    ///   - backgroundStatusBarStyle: Visual style for the top status bar.
    ///   - popupBottomPadding: Distance of the toast from the bottom edge (default: 20).
    ///     Increase it when a tab bar or other bottom chrome is present.
    ///   - popupContent: Builder for the toast content.
    public init(
        hasToShow: Binding<Bool>,
        backgroundStatusBarStyle: BackgroundStatusBarStyle,
        popupBottomPadding: CGFloat = 20,
        @ViewBuilder popupContent: @escaping () -> PopupContent
    ) {
        self._hasToShow = hasToShow
        self.popupContent = popupContent
        self.popupBottomPadding = popupBottomPadding
        self.backgroundStatusBarStyle = backgroundStatusBarStyle
    }

    public func body(content: Content) -> some View {
        content
            .backgroundStatusBar(
                isVisible: hasToShow,
                style: backgroundStatusBarStyle
            )
            .toast(
                isPresented: $hasToShow,
                autoDismissAfter: nil,
                bottomPadding: popupBottomPadding
            ) {
                popupContent()
            }
    }
}

/// Adds a top status bar and a dismissable bottom toast for app-wide states.
///
/// **Layer:** Organism
///
/// **Responsibility:**
/// Visually displays a status banner and a toast for status/alerts, styled via `BackgroundStatusBarStyle`.
///
/// **Usage:**
/// Use to indicate offline or critical app-wide status, with both a top banner and a bottom toast.
/// All visual tokens are injected via style.
///
/// Example:
/// ```swift
/// .bannerAndPopup(hasToShow: $isOffline, backgroundStatusBarStyle: .warning) {
///     Toast(icon: "wifi.slash", message: "You are offline", style: .warning)
/// }
/// ```
public extension View {
    /// Adds a top status bar and a dismissable bottom toast for an app-wide state.
    /// - Parameters:
    ///   - hasToShow: Binding controlling visibility of the top status bar / toast.
    ///   - backgroundStatusBarStyle: Style used for the top status bar.
    ///   - popupBottomPadding: Distance of the toast from the bottom edge (default: 20).
    ///     Increase it when a tab bar or other bottom chrome is present.
    ///   - popupContent: Builder for the toast content.
    func bannerAndPopup<PopupContent: View>(
        hasToShow: Binding<Bool>,
        backgroundStatusBarStyle: BackgroundStatusBarStyle,
        popupBottomPadding: CGFloat = 20,
        @ViewBuilder popupContent: @escaping () -> PopupContent
    ) -> some View {
        self.modifier(StatusBarAndPopupModifier(
            hasToShow: hasToShow,
            backgroundStatusBarStyle: backgroundStatusBarStyle,
            popupBottomPadding: popupBottomPadding,
            popupContent: popupContent
        ))
    }
}

#if DEBUG
private struct BannerAndPopupTestView: View {
    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink {
                    BannerAndPopupDetailPreview()
                } label: {
                    Text(verbatim: "Push detail")
                }

                Button(action: { isOffline.toggle() }) {
                    Text(verbatim: isOffline ? "Go online" : "Go offline")
                }
            }
            .navigationTitle(Text(verbatim: "Home"))
        }
        .bannerAndPopup(
            hasToShow: $isOffline,
            backgroundStatusBarStyle: .warning
        ) {
            Toast(icon: "wifi.slash", message: .verbatim("This is the message"), style: .warning)
        }
    }
}

private struct BannerAndPopupDetailPreview: View {
    var body: some View {
        VStack {
            Text(verbatim: "Detail screen")
        }
        .navigationTitle(Text(verbatim: "Detail"))
    }
}

#Preview {
    BannerAndPopupTestView()
}

private struct BannerAndPopupWithTabBarPreview: View {
    @State private var isOffline = true
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack(spacing: 24) {
                    Button(action: { isOffline.toggle() }) {
                        Text(verbatim: isOffline ? "Go online" : "Go offline")
                    }
                }
                .navigationTitle(Text(verbatim: "Tab 1"))
            }
            .tabItem {
                Label {
                    Text(verbatim: "Home")
                } icon: {
                    Image(systemName: "house")
                }
            }
            .tag(0)

            Text(verbatim: "Tab 2")
                .tabItem {
                    Label {
                        Text(verbatim: "Other")
                    } icon: {
                        Image(systemName: "star")
                    }
                }
                .tag(1)
        }
        .bannerAndPopup(
            hasToShow: $isOffline,
            backgroundStatusBarStyle: .warning,
            popupBottomPadding: 60
        ) {
            Toast(icon: "wifi.slash", message: .verbatim("This is the message"), style: .warning)
        }
    }
}

private struct BannerAndPopupNoTabBarPreview: View {
    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text(verbatim: "No tab bar")
                Button(action: { isOffline.toggle() }) {
                    Text(verbatim: isOffline ? "Go online" : "Go offline")
                }
            }
            .navigationTitle(Text(verbatim: "No tab bar"))
        }
        .bannerAndPopup(
            hasToShow: $isOffline,
            backgroundStatusBarStyle: .warning
        ) {
            Toast(icon: "wifi.slash", message: .verbatim("This is the message"), style: .warning)
        }
    }
}

#Preview("With Tab Bar") {
    BannerAndPopupWithTabBarPreview()
}

#Preview("No Tab Bar") {
    BannerAndPopupNoTabBarPreview()
}
#endif
