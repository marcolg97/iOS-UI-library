import SwiftUI

public extension ProgressBarStyle {
    /// Neutral (gray track, accent progress).
    static let neutral = ProgressBarStyle()

    /// Accent variant — progress uses `accentColor`, explicit track tint.
    static let accent = ProgressBarStyle(trackColor: Color.gray.opacity(0.18), progressColor: .accentColor)

    /// 3D / glossy preset — solid-fill with gloss, glow and shadow to simulate depth (no gradient).
    static let threeD = ProgressBarStyle(
        trackColor: Color.black.opacity(0.25),
        // solid progress color (no gradient) for the 3D effect
        progressColor: Color(red: 0.00, green: 0.78, blue: 0.92),
        height: 8,
        cornerRadius: 6,
        // no gradient for threeD preset — we use solid fill + overlays for gloss and glow
        progressGradientStartColor: nil,
        progressGradientEndColor: nil,
        progressGlowColor: Color(red: 0.00, green: 0.78, blue: 0.92).opacity(0.28),
        progressHighlightColor: Color.white.opacity(0.28),
        progressShadowRadius: 6
    )
}
