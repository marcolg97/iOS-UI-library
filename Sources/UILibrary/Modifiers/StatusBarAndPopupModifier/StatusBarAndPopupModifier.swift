//
//  StatusBarAndPopupModifier.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

import PopupView

// Internal constants used to control popup vertical padding. Keeps magic numbers in one place.
private enum Constants {
    static let tabBarPadding: CGFloat = 60
    static let defaultPadding: CGFloat = 20
}

/// A view modifier that adds an offline banner and a dismissable popup to any view.
/// - Parameters:
///   - showOfflineBanner: Binding controlling the offline banner visibility.
///   - popupContent: The view to display as the popup.
///   - offlineBannerBackground: The background color for the offline banner.
/// ViewModifier that displays a top status bar and a bottom popup when the app is offline.
///
/// - Layer: Organism
/// - Responsibility: Present an app-wide visual indicator (top status bar) and a transient
///   bottom popup for offline / critical status. Styling is injected via
///   `BackgroundStatusBarStyle` and `Popup` content.
/// - Usage: Apply to any root view to surface offline UI consistently across screens.
@MainActor
public struct StatusBarAndPopupModifier<PopupContent: View>: ViewModifier {
    /// Generic boolean that controls visibility of the top status bar and bottom popup.
    /// Use `hasToShow` when the modifier should represent a generic app‑wide state (offline,
    /// maintenance, restricted access, etc.). Kept generic for reusability across use cases.
    @Binding public var hasToShow: Bool

    private let popupContent: PopupContent
    private let hasTabBar: Bool
    private let backgroundStatusBarStyle: BackgroundStatusBarStyle

    @State private var showPopup: Bool = false

    /// Creates a `StatusBarAndPopupModifier`.
    /// - Parameters:
    ///   - hasToShow: Binding controlling whether the top status bar / popup is shown.
    ///   - backgroundStatusBarStyle: Visual style for the top status bar.
    ///   - hasTabBar: Whether the host view contains a tab bar (affects popup padding).
    ///   - popupContent: Builder for the popup content.
    public init(
        hasToShow: Binding<Bool>,
        backgroundStatusBarStyle: BackgroundStatusBarStyle,
        hasTabBar: Bool,
        @ViewBuilder popupContent: () -> PopupContent
    ) {
        self._hasToShow = hasToShow
        self.popupContent = popupContent()
        self.showPopup = hasToShow.wrappedValue
        self.hasTabBar = hasTabBar
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
                    .type(.floater(verticalPadding: hasTabBar ? Constants.tabBarPadding : Constants.defaultPadding))
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
/// .bannerAndPopup(hasToShow: $hasToShow, backgroundStatusBarStyle: .warning, hasTabBar: true) {
///     Popup(...)
/// }
/// ```
public extension View {
    /// Adds a top status bar and a dismissable popup for offline state.
    /// - Parameters:
    ///   - hasToShow: Binding controlling visibility of the top status bar / popup.
    ///   - backgroundStatusBarStyle: Style used for the top status bar.
    ///   - hasTabBar: Whether the host view contains a tab bar.
    ///   - popupContent: Builder for the popup content.
    func bannerAndPopup<PopupContent: View>(
        hasToShow: Binding<Bool>,
        backgroundStatusBarStyle: BackgroundStatusBarStyle,
        hasTabBar: Bool,
        @ViewBuilder popupContent: () -> PopupContent
    ) -> some View {
        self.modifier(StatusBarAndPopupModifier(
            hasToShow: hasToShow,
            backgroundStatusBarStyle: backgroundStatusBarStyle,
            hasTabBar: hasTabBar,
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
                NavigationLink(.pushDetail) {
                    DetailView2()
                }

                Button(isOffline ? .goOnline : .goOffline) {
                    isOffline.toggle()
                }
            }
            .navigationTitle(.home)
        }
        .bannerAndPopup(
            hasToShow: $isOffline,
            backgroundStatusBarStyle: .warning,
            hasTabBar: false
        ) {
            Popup(icon: "wifi.slash", message: "This is the message", style: .warning)
        }
    }
}

struct DetailView2: View {
    var body: some View {
        VStack {
            Text(.detailScreen)
        }
        .navigationTitle(.detail)
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
                    Text(.tab1)
                    Button(isOffline ? .goOnline : .goOffline) {
                        isOffline.toggle()
                    }
                }
                .navigationTitle(.tab1)
            }
            .tabItem {
                Label(.home, systemImage: "house")
            }.tag(0)

            Text(.tab2)
                .tabItem {
                    Label(.other, systemImage: "star")
                }.tag(1)
        }
        .bannerAndPopup(
            hasToShow: $isOffline,
            backgroundStatusBarStyle: .warning,
            hasTabBar: false
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
                Text(.noTabBar)
                Button(isOffline ? .goOnline : .goOffline) {
                    isOffline.toggle()
                }
            }
            .navigationTitle(.noTabBar)
        }
        .bannerAndPopup(
            hasToShow: $isOffline,
            backgroundStatusBarStyle: .warning,
            hasTabBar: false
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
