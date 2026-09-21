//
//  SettingsGroupStyle+Preset.swift
//  UILibrary
//

import SwiftUI

/// Common `SettingsGroupStyle` presets.
public extension SettingsGroupStyle {
    /// Default preset — an uppercase header above a single rounded surface.
    static let `default` = SettingsGroupStyle()

    /// Dividers span the card's full width instead of starting under the rows' text.
    static let fullWidthDividers = SettingsGroupStyle(alignsDividersWithText: false)
}
