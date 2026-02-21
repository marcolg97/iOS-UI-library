import SwiftUI

extension FormLabelStyle {
    /// Preview preset for FormLabel
    public static let previewDefault = FormLabelStyle(
        font: .subheadline.weight(.medium),
        textColor: .primary,
        iconColor: .accentColor,
        iconSize: 16,
        iconSpacing: 8,
        tracking: 0
    )
    
    /// Modern preset with larger text
    public static let modern = FormLabelStyle(
        font: .caption.weight(.bold),
        textColor: .cyan,
        iconColor: .cyan,
        iconSize: 16,
        iconSpacing: 8,
        tracking: 2
    )
}
