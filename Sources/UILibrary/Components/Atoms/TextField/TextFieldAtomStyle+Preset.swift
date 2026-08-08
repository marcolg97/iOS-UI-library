import SwiftUI

/// Example presets for TextFieldAtomStyle
/// - Layer: Atom
/// - Responsibility: Provide sample brand-agnostic presets for previews/tests
public extension TextFieldAtomStyle {
    static let `default` = TextFieldAtomStyle(
        font: .body,
        textColor: .primary,
        placeholderColor: .gray,
        backgroundColor: Color.gray.opacity(0.1),
        borderColor: .gray,
        focusedBorderColor: .accentColor,
        errorBorderColor: .red,
        borderWidth: 1,
        cornerRadius: 8,
        padding: EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12),
        disabledOpacity: 0.5
    )

    /// A compact style variant with reduced padding and subtler borders.
    static let compact = TextFieldAtomStyle(
        font: .callout,
        textColor: .primary,
        placeholderColor: .secondary,
        backgroundColor: Color.gray.opacity(0.06),
        borderColor: Color.gray.opacity(0.6),
        focusedBorderColor: .accentColor,
        errorBorderColor: .red,
        borderWidth: 1,
        cornerRadius: 6,
        padding: EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8),
        disabledOpacity: 0.45
    )

    /// A modern, elevated style with larger radius, muted background and accent-focused border.
    static let modern = TextFieldAtomStyle(
        font: .body,
        textColor: .primary,
        placeholderColor: .secondary,
        backgroundColor: Color.gray.opacity(0.1),
        borderColor: .clear,
        focusedBorderColor: .accentColor,
        errorBorderColor: .red,
        borderWidth: 1,
        cornerRadius: 12,
        padding: EdgeInsets(top: 15, leading: 14, bottom: 15, trailing: 14),
        disabledOpacity: 0.5
    )
}
