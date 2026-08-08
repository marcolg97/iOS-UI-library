//
//  CarouselView.swift
//  UILibrary
//
//  Created by Marco La Gala on 13/02/26.
//

import SwiftUI

/// Reusable horizontal carousel with snap/paging behavior and optional paging dots.
/// - Parameters:
///   - items: Identifiable data to display
///   - cardSize: Fixed size applied to every card
///   - content: ViewBuilder producing each card's content
///
/// - Note: Changing `style.scrollBehavior` at runtime rebuilds the scroll
///   view and resets the scroll position; pick a behavior per instance.
public struct CarouselView<Item: Identifiable, Content: View>: View {
    private let items: [Item]
    private let cardSize: CGSize
    private let style: CarouselViewStyle
    @ViewBuilder private let content: (Item) -> Content
    @State private var currentItemID: Item.ID?
    @State private var lastPageIndex: Int = 0

    public init(
        items: [Item],
        cardSize: CGSize,
        style: CarouselViewStyle = .default,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.cardSize = cardSize
        self.style = style
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: style.itemSpacing) {
                    ForEach(items) { item in
                        content(item)
                            .frame(
                                width: cardSize.width,
                                height: cardSize.height
                            )
                    }
                }
                .padding(.horizontal, style.horizontalPadding)
                .scrollTargetLayout()
            }
            .scrollIndicators(style.showsIndicators ? .visible : .hidden)
            .if(style.scrollBehavior == .viewAligned) { view in
                view.scrollTargetBehavior(.viewAligned)
            }
            .if(style.scrollBehavior == .paging) { view in
                view.scrollTargetBehavior(.paging)
            }
            .scrollPosition(id: $currentItemID)

            if shouldShowPagingDots {
                HStack(spacing: style.pagingDotSpacing) {
                    ForEach(itemIDs.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentPageIndex ? style.activePagingDotColor : style.inactivePagingDotColor)
                            .frame(width: style.pagingDotSize, height: style.pagingDotSize)
                            .accessibilityHidden(true)
                    }
                }
                .padding(.top, style.pagingDotsTopPadding)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(Text("Page \(currentPageIndex + 1) of \(itemIDs.count)", bundle: .module))
            }
        }
        .onAppear {
            if currentItemID == nil {
                currentItemID = items.first?.id
            }
        }
        .onChange(of: currentItemID) { _, newID in
            if let newID, let index = itemIDs.firstIndex(of: newID) {
                lastPageIndex = index
            }
        }
        .onChange(of: itemIDs) { _, newIDs in
            guard let currentItemID else {
                self.currentItemID = newIDs.first
                return
            }
            if !newIDs.contains(currentItemID) {
                self.currentItemID = newIDs.first
            }
        }
    }

    private var itemIDs: [Item.ID] {
        items.map(\.id)
    }

    private var shouldShowPagingDots: Bool {
        style.showsPagingDots && itemIDs.count > 1 && style.scrollBehavior != .none
    }

    /// Index used by the paging dots. While a scroll gesture is in flight
    /// `scrollPosition(id:)` can be `nil`; fall back to the last known page
    /// instead of snapping the dots back to the first one.
    private var currentPageIndex: Int {
        guard let currentItemID, let index = itemIDs.firstIndex(of: currentItemID) else {
            return min(lastPageIndex, max(0, itemIDs.count - 1))
        }
        return index
    }
}

#if DEBUG
private struct DemoItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
}

@MainActor
private func demoCard(item: DemoItem) -> some View {
    Card {
        VStack(alignment: .leading, spacing: 6) {
            Text(verbatim: item.title)
                .font(.title2)
                .bold()
                .dynamicTypeSize(.large ... .accessibility5)

            Text(verbatim: item.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .dynamicTypeSize(.medium ... .accessibility5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("Carousel · Preview Table") {
    let demoItems = [
        DemoItem(id: .init(), title: "One", subtitle: "First card"),
        DemoItem(id: .init(), title: "Two", subtitle: "Second card"),
        DemoItem(id: .init(), title: "Three", subtitle: "Third card"),
        DemoItem(id: .init(), title: "Four", subtitle: "Fourth card")
    ]

    VStack(spacing: 24) {
        Text(verbatim: "Default paging")
            .font(.headline)

        CarouselView(
            items: demoItems,
            cardSize: CGSize(width: 260, height: 80)
        ) { item in
            demoCard(item: item)
        }

        Text(verbatim: "Dots + paging")
            .font(.headline)

        CarouselView(
            items: demoItems,
            cardSize: CGSize(width: 220, height: 80),
            style: .withPagingDots
        ) { item in
            demoCard(item: item)
        }

        Text(verbatim: "No paging dots, custom spacing")
            .font(.headline)

        CarouselView(
            items: demoItems,
            cardSize: CGSize(width: 200, height: 80),
            style: .init(itemSpacing: 24, horizontalPadding: 24, scrollBehavior: .viewAligned, showsPagingDots: false)
        ) { item in
            demoCard(item: item)
        }
    }
    .padding()
}
#endif
