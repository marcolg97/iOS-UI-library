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
}
