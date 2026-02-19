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
        segmentSpacing: CGFloat = 4
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
    }
}
