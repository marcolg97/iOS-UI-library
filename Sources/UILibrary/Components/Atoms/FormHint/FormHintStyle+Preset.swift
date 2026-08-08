import SwiftUI

public extension FormHintStyle {
    /// Default preset for FormHint
    static let `default` = FormHintStyle(
        font: .caption,
        textColor: .secondary
    )

    /// Modern preset
    static let modern = FormHintStyle(
        font: .footnote,
        textColor: Color.gray.opacity(0.8)
    )
}
