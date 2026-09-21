//
//  SettingsRowStyle+Preset.swift
//  UILibrary
//

import SwiftUI

/// Common `SettingsRowStyle` presets.
public extension SettingsRowStyle {
    /// Default preset — a disclosure row that opens another screen.
    static let `default` = SettingsRowStyle()

    /// A row that acts in place (a toggle, a permission prompt) rather than pushing a screen, so
    /// it carries no chevron.
    static let plain = SettingsRowStyle(disclosureSystemName: nil)
}
