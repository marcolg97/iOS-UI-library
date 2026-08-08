//
//  ListItemCardStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Common presets for `ListItemCardStyle`.
public extension ListItemCardStyle {
    static let `default`: ListItemCardStyle = .init()

    /// Prominent variant with a large radius and a soft shadow.
    static let prominent: ListItemCardStyle = .init(
        cardStyle: .init(
            backgroundColor: .primary.opacity(0.05),
            cornerRadius: 24,
            padding: 20,
            shadowColor: .black.opacity(0.2),
            shadowRadius: 10,
            shadowX: 0,
            shadowY: 5
        ),
        contentSpacing: 20,
        pressedScale: 0.97
    )
}
