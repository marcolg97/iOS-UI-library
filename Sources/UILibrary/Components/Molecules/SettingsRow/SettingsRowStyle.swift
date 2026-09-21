//
//  SettingsRowStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `SettingsRow`.
public struct SettingsRowStyle: Equatable, Sendable {
    /// Tint of the leading symbol.
    public let symbolColor: Color
    /// Width reserved for the leading symbol, so every row's text starts on the same line.
    public let symbolWidth: CGFloat
    public let symbolFont: Font
    public let titleFont: Font
    public let titleColor: Color
    public let subtitleFont: Font
    public let subtitleColor: Color
    /// Chevron shown at the trailing edge. `nil` draws no chevron — for a row that toggles
    /// something in place rather than opening another screen.
    public let disclosureSystemName: String?
    public let disclosureColor: Color
    public let disclosureFont: Font
    /// Gap between the symbol, the text column and the accessory.
    public let contentSpacing: CGFloat
    public let padding: EdgeInsets
    public let pressedScale: CGFloat

    public init(
        symbolColor: Color = .accentColor,
        symbolWidth: CGFloat = 24,
        symbolFont: Font = .body,
        titleFont: Font = .body,
        titleColor: Color = .primary,
        subtitleFont: Font = .footnote,
        subtitleColor: Color = .secondary,
        disclosureSystemName: String? = "chevron.right",
        disclosureColor: Color = Color.secondary.opacity(0.6),
        disclosureFont: Font = .footnote.weight(.semibold),
        contentSpacing: CGFloat = 16,
        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        pressedScale: CGFloat = 0.97
    ) {
        self.symbolColor = symbolColor
        self.symbolWidth = symbolWidth
        self.symbolFont = symbolFont
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subtitleFont = subtitleFont
        self.subtitleColor = subtitleColor
        self.disclosureSystemName = disclosureSystemName
        self.disclosureColor = disclosureColor
        self.disclosureFont = disclosureFont
        self.contentSpacing = contentSpacing
        self.padding = padding
        self.pressedScale = pressedScale
    }

    /// Where a row's text column begins, measured from the row's leading edge. `SettingsGroup`
    /// uses it to inset the dividers so they line up under the text rather than under the symbol.
    public var textInset: CGFloat { padding.leading + symbolWidth + contentSpacing }
}
