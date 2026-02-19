//
//  Color+Hex.swift
//  DesignSystem
//
//  Created by Marco La Gala on 09/02/26.
//

import SwiftUI

public extension Color {
    /// Creates a Color from a hex string.
    ///
    /// Supports the following formats:
    /// - RGB (12-bit): "RGB"
    /// - RGB (24-bit): "RRGGBB"
    /// - ARGB (32-bit): "AARRGGBB"
    ///
    /// The hash prefix "#" is optional and will be removed if present.
    ///
    /// - Parameter hex: A hexadecimal color string (e.g., "#FF0000" or "FF0000")
    /// - Returns: A Color instance, or nil if the hex string is invalid
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    /// Converts a Color to a hex string representation.
    ///
    /// - Returns: A hexadecimal color string (e.g., "#FF0000"), or nil if conversion fails
    func toHex() -> String? {
        #if canImport(UIKit)
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        #else
        return nil
        #endif
    }
}
