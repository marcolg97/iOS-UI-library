//
//  SettingsGroupStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `SettingsGroup`.
public struct SettingsGroupStyle: Equatable, Sendable {
    /// Surface the rows sit on. Give it zero padding: the rows bring their own, and the dividers
    /// have to reach both edges.
    public let cardStyle: CardStyle
    public let headerFont: Font
    public let headerColor: Color
    public let headerTextCase: Text.Case?
    /// Leading padding on the header, to sit it just off the card's edge rather than flush with it.
    public let headerInset: CGFloat
    /// Gap between the header and the card.
    public let headerSpacing: CGFloat
    /// Divider drawn between rows. Its `leadingInset` is overridden with the row style's
    /// `textInset` unless `alignsDividersWithText` is `false`.
    public let dividerStyle: DividerStyle
    /// Whether dividers start under the rows' text (`true`) or span the full width (`false`).
    public let alignsDividersWithText: Bool

    public init(
        cardStyle: CardStyle = CardStyle(backgroundColor: Color.primary.opacity(0.05), cornerRadius: 16, padding: 0),
        headerFont: Font = .caption,
        headerColor: Color = .secondary,
        headerTextCase: Text.Case? = .uppercase,
        headerInset: CGFloat = 4,
        headerSpacing: CGFloat = 8,
        dividerStyle: DividerStyle = .default,
        alignsDividersWithText: Bool = true
    ) {
        self.cardStyle = cardStyle
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerTextCase = headerTextCase
        self.headerInset = headerInset
        self.headerSpacing = headerSpacing
        self.dividerStyle = dividerStyle
        self.alignsDividersWithText = alignsDividersWithText
    }
}
