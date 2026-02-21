import SwiftUI

/// Style contract for Form organism
public struct FormStyle: Equatable, Sendable {
    public let sectionSpacing: CGFloat
    public let padding: EdgeInsets
    public let backgroundColor: Color?
    
    public init(
        sectionSpacing: CGFloat,
        padding: EdgeInsets,
        backgroundColor: Color?
    ) {
        self.sectionSpacing = sectionSpacing
        self.padding = padding
        self.backgroundColor = backgroundColor
    }
}
