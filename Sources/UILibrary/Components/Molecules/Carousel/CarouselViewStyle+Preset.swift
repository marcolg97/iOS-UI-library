//
//  CarouselViewStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import Foundation

/// Common presets for `CarouselViewStyle`.
public extension CarouselViewStyle {
    static let `default`: CarouselViewStyle = .init()

    static let withPagingDots: CarouselViewStyle = .init(
        showsPagingDots: true
    )
}
