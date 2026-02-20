//
//  BannerStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 20/02/26.
//

import SwiftUI

/// Common, brand-agnostic `BannerStyle` presets used by apps/design systems for quick usage.
public extension BannerStyle {
    /// Creates an info-style banner (blue theme).
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "info.circle.fill").
    /// - Returns: A `BannerStyle` configured for informational messages.
    static func info(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.blue.opacity(0.15),
            iconColor: .blue,
            titleColor: .primary,
            subtitleColor: .secondary,
            actionColor: .blue,
            customIcon: customIcon ?? "info.circle.fill"
        )
    }
    
    /// Creates a warning-style banner (orange theme).
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "exclamationmark.triangle.fill").
    /// - Returns: A `BannerStyle` configured for warning messages.
    static func warning(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.orange.opacity(0.15),
            iconColor: .orange,
            titleColor: .primary,
            subtitleColor: .secondary,
            actionColor: .orange,
            customIcon: customIcon ?? "exclamationmark.triangle.fill"
        )
    }
    
    /// Creates a success-style banner (green theme).
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "checkmark.circle.fill").
    /// - Returns: A `BannerStyle` configured for success messages.
    static func success(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.green.opacity(0.15),
            iconColor: .green,
            titleColor: .primary,
            subtitleColor: .secondary,
            actionColor: .green,
            customIcon: customIcon ?? "checkmark.circle.fill"
        )
    }
    
    /// Creates an error-style banner (red theme).
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "xmark.circle.fill").
    /// - Returns: A `BannerStyle` configured for error messages.
    static func error(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.red.opacity(0.15),
            iconColor: .red,
            titleColor: .primary,
            subtitleColor: .secondary,
            actionColor: .red,
            customIcon: customIcon ?? "xmark.circle.fill"
        )
    }
}
