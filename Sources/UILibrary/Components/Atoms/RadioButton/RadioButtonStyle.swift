import SwiftUI

/// Style contract for RadioButtonAtom
public struct RadioButtonStyle: Equatable {
    public let outerSize: CGFloat
    public let innerSize: CGFloat
    public let borderWidth: CGFloat
    public let borderColor: Color
    public let backgroundColor: Color
    public let fillColor: Color
    public let disabledOpacity: Double

    public init(
        outerSize: CGFloat,
        innerSize: CGFloat,
        borderWidth: CGFloat,
        borderColor: Color,
        backgroundColor: Color,
        fillColor: Color,
        disabledOpacity: Double
    ) {
        self.outerSize = outerSize
        self.innerSize = innerSize
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.fillColor = fillColor
        self.disabledOpacity = disabledOpacity
    }
}
