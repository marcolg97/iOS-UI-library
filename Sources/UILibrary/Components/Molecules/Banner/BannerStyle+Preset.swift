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
    
    /// Creates a 3D-style info banner with elevated appearance and shadow.
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "info.circle.fill").
    /// - Returns: A `BannerStyle` configured for 3D info messages.
    static func threeDimensionalInfo(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.blue,
            iconColor: .white,
            titleColor: .white,
            subtitleColor: .white.opacity(0.9),
            actionColor: .white,
            customIcon: customIcon ?? "info.circle.fill",
            shadowColor: Color.blue.opacity(0.4),
            shadowRadius: 8,
            shadowOffset: CGSize(width: 0, height: 4)
        )
    }
    
    /// Creates a 3D-style warning banner with elevated appearance and shadow.
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "exclamationmark.triangle.fill").
    /// - Returns: A `BannerStyle` configured for 3D warning messages.
    static func threeDimensionalWarning(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.orange,
            iconColor: .white,
            titleColor: .white,
            subtitleColor: .white.opacity(0.9),
            actionColor: .white,
            customIcon: customIcon ?? "exclamationmark.triangle.fill",
            shadowColor: Color.orange.opacity(0.4),
            shadowRadius: 8,
            shadowOffset: CGSize(width: 0, height: 4)
        )
    }
    
    /// Creates a 3D-style success banner with elevated appearance and shadow.
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "checkmark.circle.fill").
    /// - Returns: A `BannerStyle` configured for 3D success messages.
    static func threeDimensionalSuccess(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.green,
            iconColor: .white,
            titleColor: .white,
            subtitleColor: .white.opacity(0.9),
            actionColor: .white,
            customIcon: customIcon ?? "checkmark.circle.fill",
            shadowColor: Color.green.opacity(0.4),
            shadowRadius: 8,
            shadowOffset: CGSize(width: 0, height: 4)
        )
    }
    
    /// Creates a 3D-style error banner with elevated appearance and shadow.
    /// - Parameters:
    ///   - customIcon: Optional custom icon (default: "xmark.circle.fill").
    /// - Returns: A `BannerStyle` configured for 3D error messages.
    static func threeDimensionalError(customIcon: String? = nil) -> BannerStyle {
        BannerStyle(
            backgroundColor: Color.red,
            iconColor: .white,
            titleColor: .white,
            subtitleColor: .white.opacity(0.9),
            actionColor: .white,
            customIcon: customIcon ?? "xmark.circle.fill",
            shadowColor: Color.red.opacity(0.4),
            shadowRadius: 8,
            shadowOffset: CGSize(width: 0, height: 4)
        )
    }
}
