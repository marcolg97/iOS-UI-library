//
//  CarouselViewStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// Scroll behavior for `CarouselView`.
public enum CarouselScrollBehavior: Equatable, Sendable {
    case viewAligned
    case paging
    case none
}

/// Style/configuration contract for `CarouselView`.
public struct CarouselViewStyle: Equatable, Sendable {
    public let itemSpacing: CGFloat
    public let horizontalPadding: CGFloat
    public let showsIndicators: Bool
    public let scrollBehavior: CarouselScrollBehavior
    public let showsPagingDots: Bool
    public let pagingDotSize: CGFloat
    public let pagingDotSpacing: CGFloat
    public let activePagingDotColor: Color
    public let inactivePagingDotColor: Color
    public let pagingDotsTopPadding: CGFloat

public init(
        itemSpacing: CGFloat = 16,
        horizontalPadding: CGFloat = 15,
        showsIndicators: Bool = false,
        scrollBehavior: CarouselScrollBehavior = .viewAligned,
        showsPagingDots: Bool = false,
        pagingDotSize: CGFloat = 8,
        pagingDotSpacing: CGFloat = 8,
        activePagingDotColor: Color = .primary,
        inactivePagingDotColor: Color = .primary.opacity(0.25),
        pagingDotsTopPadding: CGFloat = 4
    ) {
        self.itemSpacing = itemSpacing
        self.horizontalPadding = horizontalPadding
        self.showsIndicators = showsIndicators
        self.scrollBehavior = scrollBehavior
        self.showsPagingDots = showsPagingDots
        self.pagingDotSize = pagingDotSize
        self.pagingDotSpacing = pagingDotSpacing
        self.activePagingDotColor = activePagingDotColor
        self.inactivePagingDotColor = inactivePagingDotColor
        self.pagingDotsTopPadding = pagingDotsTopPadding
    }
}
