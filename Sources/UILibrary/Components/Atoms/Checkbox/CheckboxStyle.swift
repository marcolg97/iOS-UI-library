import SwiftUI

/// Style contract for CheckboxAtom
public struct CheckboxStyle: Equatable {
    public let boxSize: CGFloat
    public let checkmarkSize: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let borderColor: Color
    public let backgroundColor: Color
    public let fillColor: Color
    public let checkmarkColor: Color
    public let disabledOpacity: Double

    public init(
        boxSize: CGFloat,
        checkmarkSize: CGFloat,
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        borderColor: Color,
        backgroundColor: Color,
        fillColor: Color,
        checkmarkColor: Color,
        disabledOpacity: Double
    ) {
        self.boxSize = boxSize
        self.checkmarkSize = checkmarkSize
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.fillColor = fillColor
        self.checkmarkColor = checkmarkColor
        self.disabledOpacity = disabledOpacity
    }
}
