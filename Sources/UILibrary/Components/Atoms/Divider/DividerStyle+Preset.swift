//
//  DividerStyle+Preset.swift
//  UILibrary
//

import SwiftUI

/// Common `DividerStyle` presets.
public extension DividerStyle {
    /// Default preset — subtle hairline.
    static let `default` = DividerStyle()

    /// Inset preset — list-style divider with a leading inset.
    static let inset = DividerStyle(leadingInset: 16)
}
