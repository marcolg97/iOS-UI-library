import SwiftUI

public extension ActionButtonStyle {
    /// Primary — filled, high emphasis.
    static let primary = ActionButtonStyle()

    /// Secondary — outlined style for secondary/low-emphasis actions.
    static let secondary = ActionButtonStyle(
        backgroundColor: .clear,
        foregroundColor: .accentColor,
        disabledBackgroundColor: Color.clear,
        disabledForegroundColor: Color.primary.opacity(0.5),
        borderColor: Color.accentColor.opacity(0.12),
        shadowColor: .clear,
        defaultMaxWidth: .infinity
    )

    /// Destructive — strong red emphasis for destructive actions.
    static let destructive = ActionButtonStyle(
        backgroundColor: Color.red,
        foregroundColor: .white,
        disabledBackgroundColor: Color.red.opacity(0.3),
        disabledForegroundColor: Color.primary.opacity(0.6),
        shadowColor: Color.red.opacity(0.12),
        defaultMaxWidth: .infinity
    )

    /// Ghost/tertiary — no background or shadow, just tappable text (useful for footers).
    static let ghost = ActionButtonStyle(
        backgroundColor: .clear,
        foregroundColor: .accentColor,
        disabledBackgroundColor: .clear,
        disabledForegroundColor: Color.accentColor.opacity(0.5),
        shadowColor: .clear,
        defaultMaxWidth: nil
    )

    /// Primary (cyan) — reproduces the look of `PrimaryActionButton` used in app screens.
    static let primaryCyan = ActionButtonStyle(
        backgroundColor: Color.cyan.opacity(0.2),
        foregroundColor: Color.cyan,
        disabledBackgroundColor: Color.primary.opacity(0.04),
        disabledForegroundColor: Color.primary.opacity(0.6),
        borderColor: Color.cyan.opacity(0.5),
        disabledBorderColor: Color.primary.opacity(0.12),
        font: .headline.weight(.bold),
        cornerRadius: 16,
        shadowColor: Color.cyan.opacity(0.3),
        shadowRadius: 10,
        shadowYOffset: 5,
        defaultMaxWidth: .infinity
    )

    /// Circular icon button with an outlined border. Use for toolbar/compact icon actions.
    static let iconCircle = ActionButtonStyle(
        backgroundColor: Color.gray.opacity(0.1),
        foregroundColor: .accentColor,
        disabledBackgroundColor: .clear,
        disabledForegroundColor: Color.accentColor.opacity(0.5),
        borderColor: Color.primary.opacity(0.12),
        disabledBorderColor: Color.primary.opacity(0.06),
        font: .body,
        cornerRadius: 999,                  // fully rounded
        verticalPadding: 8,
        horizontalPadding: 10,
        minTapTarget: CGSize(width: 44, height: 44),
        shadowColor: .clear,
        defaultMaxWidth: 44
    )
} 
