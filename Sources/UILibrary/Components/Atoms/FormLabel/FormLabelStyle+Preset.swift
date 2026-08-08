import SwiftUI

public extension FormLabelStyle {
    /// Default preset for FormLabel
    static let `default` = FormLabelStyle(
        font: .subheadline.weight(.medium),
        textColor: .primary,
        iconColor: .accentColor,
        iconSize: 16,
        iconSpacing: 8,
        tracking: 0
    )

    /// Modern preset with uppercase-friendly tracking
    static let modern = FormLabelStyle(
        font: .caption.weight(.bold),
        textColor: .accentColor,
        iconColor: .accentColor,
        iconSize: 16,
        iconSpacing: 8,
        tracking: 2
    )
}
