//
//  QuizUITabbar.swift
//  UILibrary
//
//  Created by Marco La Gala on 13/02/26.
//

import SwiftUI

@MainActor
/// Protocol describing a tab item supported by `TabbarView`.
/// Conformance also provides selection metadata for ordering, icons, and iOS 18 roles.
public protocol Tabbar: CaseIterable, @MainActor Identifiable, Hashable {
    var id: String { get }
    var title: LocalizedStringResource { get }
    var systemImage: String { get }
    var order: Int { get }
    
    @available(iOS 18.0, *)
    var role: TabRole? { get }
}

/// Custom tab bar view that builds `TabView` content from a `Tabbar` enum.
public struct TabbarView<T: Tabbar, Content: View>: View {
    @Binding private var selectedTab: T
    private let content: (T) -> Content
    
    public init(
        selectedTab: Binding<T>,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self._selectedTab = selectedTab
        self.content = content
    }
    
    private var sortedTabs: [T] {
        T.allCases.sorted { $0.order < $1.order }
    }
    
    public var body: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            TabView(selection: $selectedTab) {
                ForEach(sortedTabs) { tab in
                    Tab(
                        tab.title,
                        systemImage: tab.systemImage,
                        value: tab,
                        role: tab.role
                    ) {
                        content(tab)
                    }
                }
            }
        } else {
            TabView(selection: $selectedTab) {
                ForEach(sortedTabs) { tab in
                    content(tab)
                        .tag(tab)
                        .tabItem {
                            Label(tab.title, systemImage: tab.systemImage)
                        }
                }
            }
        }
    }
}

#if DEBUG
enum TestTabs: String, @MainActor Tabbar {
    case home
    case settings
    case search
    
    var id: String { rawValue }
    
    var title: LocalizedStringResource {
        switch self {
        case .home: "Home"
        case .settings: "Settings"
        case .search: "Search"
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
        case .home: Text("Home")
        case .settings: Text("Settings")
        case .search: SearchView()
        }
    }
    
    var order: Int {
        switch self {
        case .home: 0
        case .settings: 1
        case .search: 2
        }
    }
    
    @available(iOS 18.0, *)
    var role: TabRole? {
        switch self {
        case .home: .none
        case .settings: .none
        case .search: .search
        }
    }
}

struct SearchView: View {
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Search")
                .navigationTitle("Search")
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

