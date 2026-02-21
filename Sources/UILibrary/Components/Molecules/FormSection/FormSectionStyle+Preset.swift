import SwiftUI

extension FormSectionStyle {
    /// Preview preset for FormSection (iOS-like)
    public static let previewDefault = FormSectionStyle(
        headerFont: .footnote.weight(.semibold),
        headerColor: .secondary,
        headerTextCase: .uppercase,
        footerFont: .footnote,
        footerColor: .secondary,
        contentSpacing: 8,
        itemSpacing: 16
    )
    
    /// Modern preset with no uppercase
    public static let modern = FormSectionStyle(
        headerFont: .subheadline.weight(.bold),
        headerColor: .primary,
        headerTextCase: nil,
        footerFont: .caption,
        footerColor: .secondary,
        contentSpacing: 12,
        itemSpacing: 20
    )
    
    /// Compact preset
    public static let compact = FormSectionStyle(
        headerFont: .caption.weight(.medium),
        headerColor: .secondary,
        headerTextCase: .uppercase,
        footerFont: .caption2,
        footerColor: .secondary,
        contentSpacing: 6,
        itemSpacing: 12
    )
}
