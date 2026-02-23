//
//  EmptyStateViewStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// Common, brand-agnostic `EmptyStateViewStyle` presets for quick usage.
@available(iOS 17.0, macOS 14.0, *)
public extension EmptyStateViewStyle {
    /// Creates a standard empty state style with gray theme.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "tray.fill").
    /// - Returns: An `EmptyStateViewStyle` configured for empty states.
    static func empty(iconName: String? = nil) -> EmptyStateViewStyle {
        EmptyStateViewStyle(
            iconName: iconName ?? "tray.fill",
            iconColor: .gray,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            actionButtonStyle: .primary
        )
    }
    
    /// Creates an empty search results style.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "magnifyingglass").
    /// - Returns: An `EmptyStateViewStyle` configured for empty search results.
    static func search(iconName: String? = nil) -> EmptyStateViewStyle {
        EmptyStateViewStyle(
            iconName: iconName ?? "magnifyingglass",
            iconColor: .blue,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            actionButtonStyle: .secondary
        )
    }
    
    /// Creates an empty inbox style.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "envelope.fill").
    /// - Returns: An `EmptyStateViewStyle` configured for empty inboxes.
    static func inbox(iconName: String? = nil) -> EmptyStateViewStyle {
        EmptyStateViewStyle(
            iconName: iconName ?? "envelope.fill",
            iconColor: .blue,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            actionButtonStyle: .primary
        )
    }
    
    /// Creates an empty favorites style.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "heart.fill").
    /// - Returns: An `EmptyStateViewStyle` configured for empty favorites.
    static func favorites(iconName: String? = nil) -> EmptyStateViewStyle {
        EmptyStateViewStyle(
            iconName: iconName ?? "heart.fill",
            iconColor: .pink,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            actionButtonStyle: .primary
        )
    }
    
    /// Creates an empty list style.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "list.bullet").
    /// - Returns: An `EmptyStateViewStyle` configured for empty lists.
    static func list(iconName: String? = nil) -> EmptyStateViewStyle {
        EmptyStateViewStyle(
            iconName: iconName ?? "list.bullet",
            iconColor: .gray,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            actionButtonStyle: .primary
        )
    }
    
    /// Creates a custom empty state style with specified colors and button style.
    /// - Parameters:
    ///   - iconName: SF Symbol name for the icon (default: "tray.fill").
    ///   - iconColor: Color for the icon.
    ///   - titleColor: Color for the title.
    ///   - descriptionColor: Color for the description.
    ///   - buttonStyle: Style for the action button.
    /// - Returns: A custom `EmptyStateViewStyle`.
    static func custom(
        iconName: String = "tray.fill",
        iconColor: Color,
        titleColor: Color,
        descriptionColor: Color,
        buttonStyle: ActionButtonStyle
    ) -> EmptyStateViewStyle {
        EmptyStateViewStyle(
            iconName: iconName,
            iconColor: iconColor,
            titleColor: titleColor,
            titleFont: .title2.bold(),
            descriptionColor: descriptionColor,
            descriptionFont: .body,
            actionButtonStyle: buttonStyle
        )
    }
}
