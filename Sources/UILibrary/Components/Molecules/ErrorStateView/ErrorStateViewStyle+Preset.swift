//
//  ErrorStateViewStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// Common, brand-agnostic `ErrorStateViewStyle` presets for quick usage.
public extension ErrorStateViewStyle {
    /// Creates a standard error state style with red theme.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "exclamationmark.triangle.fill").
    ///   - retryButtonTitle: Optional custom retry button title (default: "Retry").
    /// - Returns: An `ErrorStateViewStyle` configured for error states.
    static func error(
        iconName: String? = nil,
        retryButtonTitle: LocalizedStringResource? = nil
    ) -> ErrorStateViewStyle {
        ErrorStateViewStyle(
            iconName: iconName ?? "exclamationmark.triangle.fill",
            iconColor: .red,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            retryButtonTitle: retryButtonTitle ?? LocalizedStringResource("Retry", bundle: .atURL(Bundle.module.bundleURL)),
            retryButtonStyle: .primary
        )
    }

    /// Creates a network error style with custom icon and messaging.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "wifi.exclamationmark").
    ///   - retryButtonTitle: Optional custom retry button title (default: "Try Again").
    /// - Returns: An `ErrorStateViewStyle` configured for network errors.
    static func networkError(
        iconName: String? = nil,
        retryButtonTitle: LocalizedStringResource? = nil
    ) -> ErrorStateViewStyle {
        ErrorStateViewStyle(
            iconName: iconName ?? "wifi.exclamationmark",
            iconColor: .orange,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            retryButtonTitle: retryButtonTitle ?? LocalizedStringResource("Try Again", bundle: .atURL(Bundle.module.bundleURL)),
            retryButtonStyle: .primary
        )
    }
    
    /// Creates a server error style with custom icon.
    /// - Parameters:
    ///   - iconName: Optional custom icon (default: "server.rack").
    ///   - retryButtonTitle: Optional custom retry button title (default: "Refresh").
    /// - Returns: An `ErrorStateViewStyle` configured for server errors.
    static func serverError(
        iconName: String? = nil,
        retryButtonTitle: LocalizedStringResource? = nil
    ) -> ErrorStateViewStyle {
        ErrorStateViewStyle(
            iconName: iconName ?? "server.rack",
            iconColor: .red,
            titleColor: .primary,
            titleFont: .title2.bold(),
            descriptionColor: .secondary,
            descriptionFont: .body,
            retryButtonTitle: retryButtonTitle ?? LocalizedStringResource("Refresh", bundle: .atURL(Bundle.module.bundleURL)),
            retryButtonStyle: .primary
        )
    }
    
    /// Creates a custom error style with specified colors and button style.
    /// - Parameters:
    ///   - iconName: SF Symbol name for the icon (default: "xmark.circle.fill").
    ///   - iconColor: Color for the icon.
    ///   - titleColor: Color for the title.
    ///   - descriptionColor: Color for the description.
    ///   - retryButtonStyle: Style for the retry button.
    ///   - retryButtonTitle: Title for the retry button (`nil` uses the library's localized "Retry").
    /// - Returns: A custom `ErrorStateViewStyle`.
    static func custom(
        iconName: String = "xmark.circle.fill",
        iconColor: Color,
        titleColor: Color,
        descriptionColor: Color,
        retryButtonStyle: ActionButtonStyle,
        retryButtonTitle: LocalizedStringResource? = nil
    ) -> ErrorStateViewStyle {
        ErrorStateViewStyle(
            iconName: iconName,
            iconColor: iconColor,
            titleColor: titleColor,
            titleFont: .title2.bold(),
            descriptionColor: descriptionColor,
            descriptionFont: .body,
            retryButtonTitle: retryButtonTitle,
            retryButtonStyle: retryButtonStyle
        )
    }
}
