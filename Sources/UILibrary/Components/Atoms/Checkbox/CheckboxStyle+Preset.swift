import SwiftUI

public extension CheckboxStyle {
    static let `default` = CheckboxStyle(
        boxSize: 22,
        checkmarkSize: 12,
        cornerRadius: 6,
        borderWidth: 1,
        borderColor: .gray,
        backgroundColor: .clear,
        fillColor: .blue,
        checkmarkColor: .white,
        disabledOpacity: 0.5
    )

    static let compact = CheckboxStyle(
        boxSize: 18,
        checkmarkSize: 10,
        cornerRadius: 4,
        borderWidth: 1,
        borderColor: Color.gray.opacity(0.6),
        backgroundColor: .clear,
        fillColor: .blue,
        checkmarkColor: .white,
        disabledOpacity: 0.45
    )

    static let modern = CheckboxStyle(
        boxSize: 26,
        checkmarkSize: 14,
        cornerRadius: 8,
        borderWidth: 1,
        borderColor: .accentColor,
        backgroundColor: Color.gray.opacity(0.1),
        fillColor: .accentColor,
        checkmarkColor: .white,
        disabledOpacity: 0.5
    )
}
