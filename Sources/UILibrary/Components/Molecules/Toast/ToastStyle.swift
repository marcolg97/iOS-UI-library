//
//  ToastStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

import SwiftUI

/// Style contract for `Toast`.
///
/// Describes visual tokens used by `Toast` (colors, font, layout metrics).
/// Immutable and brand-agnostic.
public struct ToastStyle: Equatable, Sendable {
    /// Color used for the icon.
    public let iconColor: Color
    /// Color used for the message text.
    public let textColor: Color
    /// Background color for the toast surface.
    public let backgroundColor: Color
    /// Font for the message text.
    public let font: Font
    /// Icon frame side length.
    public let iconSize: CGFloat
    /// Horizontal spacing between icon and text.
    public let spacing: CGFloat
    /// Internal padding around toast content.
    public let padding: CGFloat
    /// Corner radius for the toast surface.
    public let cornerRadius: CGFloat

    /// Creates a `ToastStyle`.
    /// - Parameters:
    ///   - iconColor: Color for the icon.
    ///   - textColor: Color for the text.
    ///   - backgroundColor: Background color for the toast.
    ///   - font: Font for the message text (default: `.callout`).
    ///   - iconSize: Icon frame side length (default: 24).
    ///   - spacing: Spacing between icon and text (default: 8).
    ///   - padding: Internal content padding (default: 16).
    ///   - cornerRadius: Corner radius (default: 12).
    public init(
        iconColor: Color,
        textColor: Color,
        backgroundColor: Color,
        font: Font = .callout,
        iconSize: CGFloat = 24,
        spacing: CGFloat = 8,
        padding: CGFloat = 16,
        cornerRadius: CGFloat = 12
    ) {
        self.iconColor = iconColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.iconSize = iconSize
        self.spacing = spacing
        self.padding = padding
        self.cornerRadius = cornerRadius
    }
}
