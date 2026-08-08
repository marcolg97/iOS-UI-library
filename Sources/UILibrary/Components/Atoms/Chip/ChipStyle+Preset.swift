//
//  ChipStyle+Preset.swift
//  UILibrary
//

import SwiftUI

/// Common `ChipStyle` presets.
public extension ChipStyle {
    /// Default preset — neutral surface with accent-colored selection.
    static let `default` = ChipStyle()

    /// Outlined preset — transparent background with a visible border.
    static let outlined = ChipStyle(
        selectedTextColor: .accentColor,
        backgroundColor: .clear,
        selectedBackgroundColor: .accentColor.opacity(0.15),
        borderColor: Color.primary.opacity(0.25),
        selectedBorderColor: .accentColor
    )
}
