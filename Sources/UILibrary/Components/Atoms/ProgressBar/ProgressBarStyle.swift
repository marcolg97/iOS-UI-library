import SwiftUI

/// Style contract for `ProgressBar`.
///
/// Responsibility: visual tokens for `ProgressBar` (track color, progress color, height and corner radius).
/// Styles are immutable and brand‑agnostic — apps should provide concrete tokens via style factories.
public struct ProgressBarStyle: Equatable, Sendable {
    public let trackColor: Color
    public let progressColor: Color
    public let height: CGFloat
    public let cornerRadius: CGFloat
    /// Duration used by indeterminate animation (in seconds). Presentational only.
    public let indeterminateAnimationDuration: Double

    // --- Step/segment presentation tokens (used by onboarding-style segmented variant)
    public let segmentActiveColor: Color?
    public let segmentInactiveColor: Color?
    public let segmentActiveWidth: CGFloat
    public let segmentInactiveWidth: CGFloat
    public let segmentSpacing: CGFloat

    // --- 3D / material presentation tokens (opt-in)
    /// Optional gradient start color for progress fill — when provided the progress uses a left→right gradient.
    public let progressGradientStartColor: Color?
    /// Optional gradient end color for progress fill.
    public let progressGradientEndColor: Color?
    /// Subtle glow color applied behind the progress capsule to create a raised/neon effect.
    public let progressGlowColor: Color?
    /// Highlight color used to simulate gloss on top of the filled portion.
    public let progressHighlightColor: Color?
    /// Additional shadow radius applied to the filled capsule when 3D tokens are present.
    public let progressShadowRadius: CGFloat

    public init(
        trackColor: Color = Color.primary.opacity(0.12),
        progressColor: Color = .accentColor,
        height: CGFloat = 6,
        cornerRadius: CGFloat = 3,
        indeterminateAnimationDuration: Double = 1.2,
        // step/segment defaults - keep optional colors to fall back to existing tokens when nil
        segmentActiveColor: Color? = nil,
        segmentInactiveColor: Color? = nil,
        segmentActiveWidth: CGFloat = 50,
        segmentInactiveWidth: CGFloat = 25,
        segmentSpacing: CGFloat = 4,
        // 3D defaults (nil = disabled)
        progressGradientStartColor: Color? = nil,
        progressGradientEndColor: Color? = nil,
        progressGlowColor: Color? = nil,
        progressHighlightColor: Color? = nil,
        progressShadowRadius: CGFloat = 0
    ) {
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.height = height
        self.cornerRadius = cornerRadius
        self.indeterminateAnimationDuration = indeterminateAnimationDuration
        self.segmentActiveColor = segmentActiveColor
        self.segmentInactiveColor = segmentInactiveColor
        self.segmentActiveWidth = segmentActiveWidth
        self.segmentInactiveWidth = segmentInactiveWidth
        self.segmentSpacing = segmentSpacing
        self.progressGradientStartColor = progressGradientStartColor
        self.progressGradientEndColor = progressGradientEndColor
        self.progressGlowColor = progressGlowColor
        self.progressHighlightColor = progressHighlightColor
        self.progressShadowRadius = progressShadowRadius
    }
}
