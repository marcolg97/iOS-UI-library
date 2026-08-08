//
//  Tabbar.swift
//  UILibrary
//
//  Created by Marco La Gala on 13/02/26.
//

import SwiftUI

/// Protocol describing a tab item supported by `TabbarView`.
/// Conformance also provides selection metadata for ordering, icons, badges,
/// and tab roles.
@MainActor
public protocol TabbarItem: CaseIterable, @MainActor Identifiable, Hashable {
    var id: String { get }
    var title: LocalizedStringResource { get }
    var systemImage: String { get }
    var order: Int { get }

    /// Optional badge count shown on the tab (nil = no badge).
    var badgeCount: Int? { get }

    @available(iOS 18.0, macOS 15.0, *)
    var role: TabRole? { get }
}

public extension TabbarItem {
    var badgeCount: Int? { nil }
}

@available(*, deprecated, renamed: "TabbarItem")
public typealias Tabbar = TabbarItem

/// Custom tab bar view that builds `TabView` content from `TabbarItem` values.
///
/// By default all cases of the conforming enum are shown (sorted by `order`);
/// pass an explicit `tabs` array to show a dynamic subset (feature flags,
/// user preferences, …).
///
/// - Note: The system tab bar owns most of its appearance; `TabbarStyle`
///   exposes the tokens SwiftUI allows a library to control (tint).
public struct TabbarView<T: TabbarItem, Content: View>: View {
    @Binding private var selectedTab: T
    private let tabs: [T]
    private let style: TabbarStyle
    private let content: (T) -> Content

    public init(
        selectedTab: Binding<T>,
        tabs: [T]? = nil,
        style: TabbarStyle = .default,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self._selectedTab = selectedTab
        self.tabs = (tabs ?? Array(T.allCases)).sorted { $0.order < $1.order }
        self.style = style
        self.content = content
    }

    public var body: some View {
        Group {
            if #available(iOS 18.0, macOS 15.0, *) {
                TabView(selection: $selectedTab) {
                    ForEach(tabs) { tab in
                        Tab(value: tab, role: tab.role) {
                            content(tab)
                        } label: {
                            Label {
                                Text(tab.title)
                            } icon: {
                                Image(systemName: tab.systemImage)
                            }
                        }
                        .badge(tab.badgeCount ?? 0)
                    }
                }
            } else {
                TabView(selection: $selectedTab) {
                    ForEach(tabs) { tab in
                        content(tab)
                            .tag(tab)
                            .tabItem {
                                Label {
                                    Text(tab.title)
                                } icon: {
                                    Image(systemName: tab.systemImage)
                                }
                            }
                            .badge(tab.badgeCount ?? 0)
                    }
                }
            }
        }
        .if(style.tint != nil) { view in
            view.tint(style.tint)
        }
    }
}

#if DEBUG
private enum TestTabs: String, @MainActor TabbarItem {
    case home
    case settings
    case search

    var id: String { rawValue }

    var title: LocalizedStringResource {
        switch self {
        case .home: .verbatim("Home")
        case .settings: .verbatim("Settings")
        case .search: .verbatim("Search")
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house"
        case .settings: "gear"
        case .search: "magnifyingglass"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .home: Text(verbatim: "Home")
        case .settings: Text(verbatim: "Settings")
        case .search: TestSearchView()
        }
    }

    var order: Int {
        switch self {
        case .home: 0
        case .settings: 1
        case .search: 2
        }
    }

    @available(iOS 18.0, macOS 15.0, *)
    var role: TabRole? {
        switch self {
        case .home: .none
        case .settings: .none
        case .search: .search
        }
    }
}

private struct TestSearchView: View {
    @State private var searchTerm: String = ""

    var body: some View {
        NavigationStack {
            Text(verbatim: "Search")
                .navigationTitle(Text(verbatim: "Search"))
                .searchable(text: $searchTerm)
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: TestTabs = .home

    TabbarView(selectedTab: $selectedTab) { tab in
        tab.view
    }
}
#endif
