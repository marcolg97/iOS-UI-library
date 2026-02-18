//
//  StatusBarAndPopupModifier.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

import PopupView

/// A view modifier that adds an offline banner and a dismissable popup to any view.
/// - Parameters:
///   - showOfflineBanner: Binding controlling the offline banner visibility.
///   - popupContent: The view to display as the popup.
///   - offlineBannerBackground: The background color for the offline banner.
public struct StatusBarAndPopupModifier<PopupContent: View>: ViewModifier {
    /// Global offline state — controls visibility of both the status bar and popup.
    @Binding public var hasToShow: Bool

    private let popupContent: PopupContent
    private let hasTabbar: Bool
    private let backgroundStatusBarStyle: BackgroundStatusBarStyle

    @State private var showPopup: Bool = false

    /// Creates a `StatusBarAndPopupModifier`.
    /// - Parameters:
    ///   - isOffline: Binding controlling whether the offline UI is shown.
    ///   - backgroundStatusBarStyle: Visual style for the top status bar.
    ///   - hasTabbar: Whether the host view contains a tab bar (affects popup padding).
    ///   - popupContent: Builder for the popup content.
    public init(
        isOffline: Binding<Bool>,
        backgroundStatusBarStyle: BackgroundStatusBarStyle,
        hasTabbar: Bool,
        @ViewBuilder popupContent: () -> PopupContent
    ) {
        self._hasToShow = isOffline
        self.popupContent = popupContent()
        self.showPopup = isOffline.wrappedValue
        self.hasTabbar = hasTabbar
        self.backgroundStatusBarStyle = backgroundStatusBarStyle
    }

    public func body(content: Content) -> some View {
        content
            .backgroundStatusBar(
                isVisible: hasToShow,
                style: backgroundStatusBarStyle
            )
            .popup(isPresented: $showPopup) {
                popupContent
            } customize: {
                $0
                    .type(.floater(verticalPadding: hasTabbar ? 60 : 20))
                    .position(.bottom)
                    .animation(.spring())
            }
            .onChange(of: hasToShow) { _, newValue in
                showPopup = newValue
            }
    }
}

/// Adds an offline status bar at the top and a dismissable popup at the bottom of any view.
///
/// **Layer:** Organism
///
/// **Responsibility:**
/// Visually displays an offline banner and a popup for status/alerts, styled via `BackgroundStatusBarStyle`.
///
/// **Usage:**
/// Use to indicate offline or critical app-wide status, with both a top banner and a bottom popup. All visual tokens are injected via style.
///
/// Example:
/// ```swift
/// .bannerAndPopup(isOffline: $isOffline, backgroundStatusBarStyle: .warning, hasTabbar: true) {
///     Popup(...)
/// }
/// ```
public extension View {
    /// Adds a top status bar and a dismissable popup for offline state.
    /// - Parameters:
    ///   - isOffline: Binding controlling visibility of the offline UI.
    ///   - backgroundStatusBarStyle: Style used for the top status bar.
    ///   - hasTabbar: Whether the host view contains a tab bar.
    ///   - popupContent: Builder for the popup content.
    func bannerAndPopup<PopupContent: View>(
        isOffline: Binding<Bool>,
        backgroundStatusBarStyle: BackgroundStatusBarStyle,
        hasTabbar: Bool,
        @ViewBuilder popupContent: () -> PopupContent
    ) -> some View {
        self.modifier(StatusBarAndPopupModifier(
            isOffline: isOffline,
            backgroundStatusBarStyle: backgroundStatusBarStyle,
            hasTabbar: hasTabbar,
            popupContent: popupContent
        ))
    }
}

#if DEBUG
struct BannerAndPopupTestView: View {
    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink("Push detail") {
                    DetailView2()
                }

                Button(isOffline ? "Go Online" : "Go Offline") {
                    isOffline.toggle()
                }
            }
            .navigationTitle("Home")
        }
        .bannerAndPopup(
            isOffline: $isOffline,
            backgroundStatusBarStyle: .warning,
            hasTabbar: false
        ) {
            Popup(icon: "wifi.slash", message: "This is the message", style: .warning)
        }
    }
}

struct DetailView2: View {
    var body: some View {
        VStack {
            Text("Detail screen")
        }
        .navigationTitle("Detail")
    }
}

// MARK: - Preview

#Preview {
    BannerAndPopupTestView()
}
#endif


// MARK: - Preview con TabBar e senza

#if DEBUG
struct BannerAndPopupWithTabBarPreview: View {
    @State private var isOffline = true
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack(spacing: 24) {
                    Text("Tab 1")
                    Button(isOffline ? "Go Online" : "Go Offline") {
                        isOffline.toggle()
                    }
                }
                .navigationTitle("Tab 1")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }.tag(0)

            Text("Tab 2")
                .tabItem {
                    Label("Other", systemImage: "star")
                }.tag(1)
        }
        .bannerAndPopup(
            isOffline: $isOffline,
            backgroundStatusBarStyle: .warning,
            hasTabbar: false
        ) {
            Popup(icon: "wifi.slash", message: "This is the message", style: .warning)
        }
    }
}

struct BannerAndPopupNoTabBarPreview: View {
    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("No Tab Bar")
                Button(isOffline ? "Go Online" : "Go Offline") {
                    isOffline.toggle()
                }
            }
            .navigationTitle("No Tab Bar")
        }
        .bannerAndPopup(
            isOffline: $isOffline,
            backgroundStatusBarStyle: .warning,
            hasTabbar: false
        ) {
            Popup(icon: "wifi.slash", message: "This is the message", style: .warning)
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
