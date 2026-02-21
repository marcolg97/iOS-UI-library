import SwiftUI

/// Style contract for FormHint atom
public struct FormHintStyle: Equatable, Sendable {
    public let font: Font
    public let textColor: Color
    
    public init(
        font: Font,
        textColor: Color
    ) {
        self.font = font
        self.textColor = textColor
    }
}
