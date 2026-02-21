import SwiftUI

/// Style contract for FormSection molecule
public struct FormSectionStyle: Equatable, Sendable {
    public let headerFont: Font
    public let headerColor: Color
    public let headerTextCase: Text.Case?
    public let footerFont: Font
    public let footerColor: Color
    public let contentSpacing: CGFloat
    public let itemSpacing: CGFloat
    
    public init(
        headerFont: Font,
        headerColor: Color,
        headerTextCase: Text.Case?,
        footerFont: Font,
        footerColor: Color,
        contentSpacing: CGFloat,
        itemSpacing: CGFloat
    ) {
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerTextCase = headerTextCase
        self.footerFont = footerFont
        self.footerColor = footerColor
        self.contentSpacing = contentSpacing
        self.itemSpacing = itemSpacing
    }
}
