//
//  ListItemCardStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Style contract for `ListItemCard`.
///
/// Defines visual tokens for spacing, base card appearance, and pressed-state scaling.
public struct ListItemCardStyle: Equatable, Sendable {
    public let cardStyle: CardStyle
    public let contentSpacing: CGFloat
    public let pressedScale: CGFloat

    public init(
        cardStyle: CardStyle = .neutral,
        contentSpacing: CGFloat = 16,
        pressedScale: CGFloat = 0.97
    ) {
        self.cardStyle = cardStyle
        self.contentSpacing = contentSpacing
        self.pressedScale = pressedScale
    }
}
