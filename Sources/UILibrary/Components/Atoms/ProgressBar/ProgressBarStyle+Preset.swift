import SwiftUI

public extension ProgressBarStyle {
    /// Neutral (gray track, accent progress).
    static let neutral = ProgressBarStyle()

    /// Accent variant — progress uses `accentColor`, explicit track tint.
    static let accent = ProgressBarStyle(trackColor: Color.gray.opacity(0.18), progressColor: .accentColor)
}
