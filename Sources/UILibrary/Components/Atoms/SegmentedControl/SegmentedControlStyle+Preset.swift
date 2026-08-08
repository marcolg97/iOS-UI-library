//
//  SegmentedControlStyle+Preset.swift
//  UILibrary
//

import SwiftUI

/// Common `SegmentedControlStyle` presets.
public extension SegmentedControlStyle {
    /// Default preset — neutral, system-like appearance.
    static let `default` = SegmentedControlStyle()

    /// Accent preset — accent-colored selection indicator with white text.
    static let accent = SegmentedControlStyle(
        selectedTextColor: .white,
        selectedBackgroundColor: .accentColor
    )
}
