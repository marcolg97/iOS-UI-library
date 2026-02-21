import SwiftUI

public extension CheckboxStyle {
    static var previewDefault: CheckboxStyle {
        .init(
            boxSize: 22,
            checkmarkSize: 12,
            cornerRadius: 6,
            borderWidth: 1,
            borderColor: .gray,
            backgroundColor: .white,
            fillColor: .blue,
            checkmarkColor: .white,
            disabledOpacity: 0.5
        )
    }

    static var compact: CheckboxStyle {
        .init(
            boxSize: 18,
            checkmarkSize: 10,
            cornerRadius: 4,
            borderWidth: 1,
            borderColor: Color.gray.opacity(0.6),
            backgroundColor: Color.white,
            fillColor: Color.blue,
            checkmarkColor: .white,
            disabledOpacity: 0.45
        )
    }

    static var modern: CheckboxStyle {
        .init(
            boxSize: 26,
            checkmarkSize: 14,
            cornerRadius: 8,
            borderWidth: 1,
            borderColor: .cyan,
            backgroundColor: Color.gray.opacity(0.1),
            fillColor: .cyan,
            checkmarkColor: .white,
            disabledOpacity: 0.5
        )
    }
}
