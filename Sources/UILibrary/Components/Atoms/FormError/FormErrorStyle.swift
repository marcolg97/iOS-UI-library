import SwiftUI

/// Style contract for FormError atom
public struct FormErrorStyle: Equatable, Sendable {
    public let font: Font
    public let textColor: Color
    public let iconSystemName: String?
    public let iconSize: CGFloat
    public let iconSpacing: CGFloat
    
    public init(
        font: Font,
        textColor: Color,
        iconSystemName: String? = nil,
        iconSize: CGFloat,
        iconSpacing: CGFloat
    ) {
        self.font = font
        self.textColor = textColor
        self.iconSystemName = iconSystemName
        self.iconSize = iconSize
        self.iconSpacing = iconSpacing
    }
}
