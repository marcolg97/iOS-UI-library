import SwiftUI

public extension BadgeStyle {
    /// Default badge style with neutral gray background.
    static let `default` = BadgeStyle()
    
    /// Neutral style with slightly darker background — useful for emphasis.
    static let neutral = BadgeStyle(
        backgroundColor: Color.primary.opacity(0.15),
        foregroundColor: Color.primary,
        font: .caption.weight(.medium)
    )
    
    /// Accent style — blue tint for highlighting key information.
    static let accent = BadgeStyle(
        backgroundColor: Color.blue.opacity(0.16),
        foregroundColor: Color.blue,
        font: .caption.weight(.semibold)
    )
    
    /// Success style — green tint for positive states.
    static let success = BadgeStyle(
        backgroundColor: Color.green.opacity(0.16),
        foregroundColor: Color.green,
        font: .caption.weight(.semibold)
    )
    
    /// Warning style — orange/yellow tint for warnings.
    static let warning = BadgeStyle(
        backgroundColor: Color.orange.opacity(0.16),
        foregroundColor: Color.orange,
        font: .caption.weight(.semibold)
    )
    
    /// Error/Alert style — red tint for errors or critical states.
    static let error = BadgeStyle(
        backgroundColor: Color.red.opacity(0.16),
        foregroundColor: Color.red,
        font: .caption.weight(.semibold)
    )
    
    /// Outlined variant — clear background with border.
    static func outlined(_ color: Color = .primary) -> BadgeStyle {
        BadgeStyle(
            backgroundColor: .clear,
            foregroundColor: color,
            font: .caption.weight(.medium),
            borderColor: color.opacity(0.3),
            borderWidth: 1
        )
    }
    
    /// Minimal circular dot variant — no visible text, just a filled circle. Use for lightweight
    /// status indicators (e.g. "has updates", "table incomplete") where a full text/count badge
    /// would be visually heavy. Pair with `Badge.dot(accessibilityLabel:style:)`, which supplies
    /// the VoiceOver label that a dot has no visible text to provide on its own.
    /// - Parameters:
    ///   - color: Fill color of the dot (default: `.primary`).
    ///   - diameter: Diameter of the dot in points (default: 10).
    /// - Returns: A `BadgeStyle` that renders `Badge` as a plain filled circle.
    static func dot(_ color: Color = .primary, diameter: CGFloat = 10) -> BadgeStyle {
        BadgeStyle(
            backgroundColor: color,
            verticalPadding: 0,
            horizontalPadding: 0,
            cornerRadius: diameter / 2,
            dotDiameter: diameter
        )
    }

    /// 3D variant with elevated appearance and shadow.
    /// - Parameter color: The base color for the badge (default: .blue).
    /// - Returns: A `BadgeStyle` with 3D shadow effect.
    static func threeDimensional(_ color: Color = .blue) -> BadgeStyle {
        BadgeStyle(
            backgroundColor: color,
            foregroundColor: .white,
            font: .caption.weight(.bold),
            verticalPadding: 6,
            horizontalPadding: 10,
            cornerRadius: 10,
            shadowColor: color.opacity(0.4),
            shadowRadius: 4,
            shadowOffset: CGSize(width: 0, height: 3)
        )
    }
}
