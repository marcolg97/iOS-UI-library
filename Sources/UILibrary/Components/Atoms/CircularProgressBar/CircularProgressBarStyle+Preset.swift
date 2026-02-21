//
//  CircularProgressBarStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Common presets for `CircularProgressBarStyle`.
public extension CircularProgressBarStyle {
    static let `default`: CircularProgressBarStyle = .init(
        trackColor: .primary.opacity(0.1),
        progressGradientColors: [.cyan, Color(hex: "00B4D8") ?? .cyan],
        shineGradientColors: [.white.opacity(0.4), .clear],
        textColor: .primary
    )
}
