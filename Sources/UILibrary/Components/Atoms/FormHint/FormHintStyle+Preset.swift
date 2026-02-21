import SwiftUI

extension FormHintStyle {
    /// Preview preset for FormHint
    public static let previewDefault = FormHintStyle(
        font: .caption,
        textColor: .secondary
    )
    
    /// Modern preset
    public static let modern = FormHintStyle(
        font: .footnote,
        textColor: Color.gray.opacity(0.8)
    )
}
