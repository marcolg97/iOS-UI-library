import SwiftUI

/// Style contract for `LabelImage`.
///
/// Defines spacing, typography and colors used by the convenience initializers.
public struct LabelImageStyle: Equatable, Sendable {
    public enum IconPosition: Sendable, Equatable {
        case leading
        case trailing
    }

    public let iconPosition: IconPosition
    public let spacing: CGFloat
    public let font: Font
    public let textColor: Color
    public let iconColor: Color
    public let hideIconFromAccessibility: Bool

    public init(
        iconPosition: IconPosition = .leading,
        spacing: CGFloat = 8,
        font: Font = .body,
        textColor: Color = .primary,
        iconColor: Color = .primary,
        hideIconFromAccessibility: Bool = true
    ) {
        self.iconPosition = iconPosition
        self.spacing = spacing
        self.font = font
        self.textColor = textColor
        self.iconColor = iconColor
        self.hideIconFromAccessibility = hideIconFromAccessibility
    }
}
