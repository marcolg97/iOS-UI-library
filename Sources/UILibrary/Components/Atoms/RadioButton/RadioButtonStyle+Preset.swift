import SwiftUI

public extension RadioButtonStyle {
    static var previewDefault: RadioButtonStyle {
        .init(
            outerSize: 22,
            innerSize: 10,
            borderWidth: 1,
            borderColor: .gray,
            backgroundColor: .white,
            fillColor: .blue,
            disabledOpacity: 0.5
        )
    }

    static var compact: RadioButtonStyle {
        .init(
            outerSize: 18,
            innerSize: 8,
            borderWidth: 1,
            borderColor: Color.gray.opacity(0.6),
            backgroundColor: Color.white,
            fillColor: Color.blue,
            disabledOpacity: 0.45
        )
    }

    static var modern: RadioButtonStyle {
        .init(
            outerSize: 26,
            innerSize: 12,
            borderWidth: 1,
            borderColor: .cyan,
            backgroundColor: Color.gray.opacity(0.1),
            fillColor: .cyan,
            disabledOpacity: 0.5
        )
    }
}
