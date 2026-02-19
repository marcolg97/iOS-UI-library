import SwiftUI

/// Style contract for `GhostButton`.
///
/// Defines colors, font and underline behavior for the ghost button.
public struct GhostButtonStyle: Equatable, Sendable {
    public let textColor: Color
    public let iconColor: Color
    public let font: Font
    public let underline: Bool
    public let minTapTarget: CGSize

    /// Creates a `GhostButtonStyle`.
    public init(
        textColor: Color = .accentColor,
        iconColor: Color = .accentColor,
        font: Font = .body,
        underline: Bool = true,
        minTapTarget: CGSize = CGSize(width: 44, height: 44)
    ) {
        self.textColor = textColor
        self.iconColor = iconColor
        self.font = font
        self.underline = underline
        self.minTapTarget = minTapTarget
    }
}
