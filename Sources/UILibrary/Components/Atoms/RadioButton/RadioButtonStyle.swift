import SwiftUI

/// Style contract for RadioButtonAtom
public struct RadioButtonStyle: Equatable, Sendable {
    public let outerSize: CGFloat
    public let innerSize: CGFloat
    public let borderWidth: CGFloat
    public let borderColor: Color
    public let backgroundColor: Color
    public let fillColor: Color
    public let disabledOpacity: Double
    /// Minimum tap-target side length. The hit area is expanded to at least
    /// this size (HIG recommends 44pt) without changing the drawn control size.
    public let minTapTarget: CGFloat

    public init(
        outerSize: CGFloat,
        innerSize: CGFloat,
        borderWidth: CGFloat,
        borderColor: Color,
        backgroundColor: Color,
        fillColor: Color,
        disabledOpacity: Double,
        minTapTarget: CGFloat = 44
    ) {
        self.outerSize = outerSize
        self.innerSize = innerSize
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.fillColor = fillColor
        self.disabledOpacity = disabledOpacity
        self.minTapTarget = minTapTarget
    }
}
