import SwiftUI

public extension FormErrorStyle {
    /// Default preset for FormError
    static let `default` = FormErrorStyle(
        font: .caption,
        textColor: .red,
        iconSize: 12,
        iconSpacing: 4,
        iconSystemName: "exclamationmark.triangle.fill"
    )

    /// Modern preset with different icon
    static let modern = FormErrorStyle(
        font: .footnote,
        textColor: Color(red: 0.9, green: 0.2, blue: 0.2),
        iconSize: 14,
        iconSpacing: 6,
        iconSystemName: "xmark.circle.fill"
    )
}
