import SwiftUI

public extension RadioButtonStyle {
    static let `default` = RadioButtonStyle(
        outerSize: 22,
        innerSize: 10,
        borderWidth: 1,
        borderColor: .gray,
        backgroundColor: .clear,
        fillColor: .blue,
        disabledOpacity: 0.5
    )

    static let compact = RadioButtonStyle(
        outerSize: 18,
        innerSize: 8,
        borderWidth: 1,
        borderColor: Color.gray.opacity(0.6),
        backgroundColor: .clear,
        fillColor: .blue,
        disabledOpacity: 0.45
    )

    static let modern = RadioButtonStyle(
        outerSize: 26,
        innerSize: 12,
        borderWidth: 1,
        borderColor: .accentColor,
        backgroundColor: Color.gray.opacity(0.1),
        fillColor: .accentColor,
        disabledOpacity: 0.5
    )
}
