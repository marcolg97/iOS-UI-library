import SwiftUI

extension FormStyle {
    /// Preview preset for Form
    public static let previewDefault = FormStyle(
        sectionSpacing: 32,
        padding: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        backgroundColor: nil
    )
    
    /// Modern preset with background
    public static let modern = FormStyle(
        sectionSpacing: 40,
        padding: EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20),
        backgroundColor: Color.gray.opacity(0.08)
    )
    
    /// Compact preset
    public static let compact = FormStyle(
        sectionSpacing: 24,
        padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12),
        backgroundColor: nil
    )
}
