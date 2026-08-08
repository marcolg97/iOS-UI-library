//
//  EmptyStateViewStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// Style contract for `EmptyStateView`.
///
/// Describes visual tokens used by `EmptyStateView` (icon, colors, fonts, button style).
/// Immutable and brand-agnostic.
public struct EmptyStateViewStyle: Equatable, Sendable {
    /// SF Symbol name for the empty state icon.
    public let iconName: String
    
    /// Color for the empty state icon.
    public let iconColor: Color
    
    /// Color for the title text.
    public let titleColor: Color
    
    /// Font for the title text.
    public let titleFont: Font
    
    /// Color for the description text.
    public let descriptionColor: Color
    
    /// Font for the description text.
    public let descriptionFont: Font
    
    /// Style for the optional action button.
    public let actionButtonStyle: ActionButtonStyle
    
    /// Creates an `EmptyStateViewStyle`.
    /// - Parameters:
    ///   - iconName: SF Symbol name for the icon (default: "tray.fill").
    ///   - iconColor: Color for the icon (default: .gray).
    ///   - titleColor: Color for the title (default: .primary).
    ///   - titleFont: Font for the title (default: .title2.bold()).
    ///   - descriptionColor: Color for the description (default: .secondary).
    ///   - descriptionFont: Font for the description (default: .body).
    ///   - actionButtonStyle: Style for the action button (default: .primary).
    public init(
        iconName: String = "tray.fill",
        iconColor: Color = .gray,
        titleColor: Color = .primary,
        titleFont: Font = .title2.bold(),
        descriptionColor: Color = .secondary,
        descriptionFont: Font = .body,
        actionButtonStyle: ActionButtonStyle = .primary
    ) {
        self.iconName = iconName
        self.iconColor = iconColor
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.descriptionColor = descriptionColor
        self.descriptionFont = descriptionFont
        self.actionButtonStyle = actionButtonStyle
    }
}
