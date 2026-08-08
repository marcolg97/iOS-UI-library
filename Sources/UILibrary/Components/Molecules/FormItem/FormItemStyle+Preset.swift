import SwiftUI

public extension FormItemStyle {
    /// Default preset for FormItem
    static let `default` = FormItemStyle(spacing: 8)

    /// Compact preset with less spacing
    static let compact = FormItemStyle(spacing: 4)

    /// Spacious preset with more spacing
    static let spacious = FormItemStyle(spacing: 12)
}
