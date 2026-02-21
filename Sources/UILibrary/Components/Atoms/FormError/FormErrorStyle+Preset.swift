import SwiftUI

extension FormErrorStyle {
    /// Preview preset for FormError
    public static let previewDefault = FormErrorStyle(
        font: .caption,
        textColor: .red,
        iconSystemName: "exclamationmark.triangle.fill",
        iconSize: 12,
        iconSpacing: 4
    )
    
    /// Modern preset with different icon
    public static let modern = FormErrorStyle(
        font: .footnote,
        textColor: Color(red: 0.9, green: 0.2, blue: 0.2),
        iconSystemName: "xmark.circle.fill",
        iconSize: 14,
        iconSpacing: 6
    )
}
