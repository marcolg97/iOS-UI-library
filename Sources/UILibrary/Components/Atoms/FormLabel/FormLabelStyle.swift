import SwiftUI

/// Style contract for FormLabel atom
public struct FormLabelStyle: Equatable, Sendable {
    public let font: Font
    public let textColor: Color
    public let iconColor: Color
    public let iconSize: CGFloat
    public let iconSpacing: CGFloat
    public let tracking: CGFloat

    public init(
        font: Font,
        textColor: Color,
        iconColor: Color,
        iconSize: CGFloat,
        iconSpacing: CGFloat,
        tracking: CGFloat = 0
    ) {
        self.font = font
        self.textColor = textColor
        self.iconColor = iconColor
        self.iconSize = iconSize
        self.iconSpacing = iconSpacing
        self.tracking = tracking
    }
}
