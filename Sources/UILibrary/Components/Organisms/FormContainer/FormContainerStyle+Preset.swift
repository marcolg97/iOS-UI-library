import SwiftUI

public extension FormContainerStyle {
    /// Default preset for FormContainer
    static let `default` = FormContainerStyle(
        sectionSpacing: 32,
        padding: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    )

    /// Modern preset with background
    static let modern = FormContainerStyle(
        sectionSpacing: 40,
        padding: EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20),
        backgroundColor: Color.gray.opacity(0.08)
    )

    /// Compact preset
    static let compact = FormContainerStyle(
        sectionSpacing: 24,
        padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
    )
}
