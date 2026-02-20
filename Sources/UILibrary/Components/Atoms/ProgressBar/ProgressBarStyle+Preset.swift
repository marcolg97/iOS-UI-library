import SwiftUI

public extension ProgressBarStyle {
    /// Neutral (gray track, accent progress).
    static let neutral = ProgressBarStyle()

    /// Accent variant — progress uses `accentColor`, explicit track tint.
    static let accent = ProgressBarStyle(trackColor: Color.gray.opacity(0.18), progressColor: .accentColor)

    /// 3D / glossy gradient preset — adds gradient fill, subtle glow and highlight for a raised look.
    static let threeD = ProgressBarStyle(
        trackColor: Color.black.opacity(0.25),
        progressColor: Color.cyan,
        height: 8,
        cornerRadius: 6,
        progressGradientStartColor: Color(red: 0.00, green: 0.78, blue: 0.92),
        progressGradientEndColor: Color(red: 0.00, green: 0.50, blue: 0.85),
        progressGlowColor: Color.cyan.opacity(0.28),
        progressHighlightColor: Color.white.opacity(0.32),
        progressShadowRadius: 6
    )
}
