import SwiftUI

/// Style contract for TextFieldAtom
/// - Layer: Atom
/// - Responsibility: All visual tokens for TextFieldAtom
/// - Usage: Inject from app/design system
public struct TextFieldAtomStyle: Equatable {
    public let font: Font
    public let textColor: Color
    public let placeholderColor: Color
    public let backgroundColor: Color
    public let borderColor: Color
    public let focusedBorderColor: Color
    public let errorBorderColor: Color
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    public let padding: EdgeInsets
    public let disabledOpacity: Double

    public init(
        font: Font,
        textColor: Color,
        placeholderColor: Color,
        backgroundColor: Color,
        borderColor: Color,
        focusedBorderColor: Color,
        errorBorderColor: Color,
        borderWidth: CGFloat,
        cornerRadius: CGFloat,
        padding: EdgeInsets,
        disabledOpacity: Double
    ) {
        self.font = font
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.focusedBorderColor = focusedBorderColor
        self.errorBorderColor = errorBorderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.disabledOpacity = disabledOpacity
    }
}
