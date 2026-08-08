import SwiftUI

/// Style contract for FormError atom
public struct FormErrorStyle: Equatable, Sendable {
    public let font: Font
    public let textColor: Color
    public let iconSize: CGFloat
    public let iconSpacing: CGFloat
    public let iconSystemName: String?

    public init(
        font: Font,
        textColor: Color,
        iconSize: CGFloat,
        iconSpacing: CGFloat,
        iconSystemName: String? = nil
    ) {
        self.font = font
        self.textColor = textColor
        self.iconSize = iconSize
        self.iconSpacing = iconSpacing
        self.iconSystemName = iconSystemName
    }
}
