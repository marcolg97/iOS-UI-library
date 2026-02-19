import SwiftUI

public extension LabelImageStyle {
    /// Default neutral style.
    static let neutral = LabelImageStyle()

    /// Compact style — slightly reduced spacing and smaller font for dense layouts.
    static let compact = LabelImageStyle(spacing: 4, font: .subheadline)
}
