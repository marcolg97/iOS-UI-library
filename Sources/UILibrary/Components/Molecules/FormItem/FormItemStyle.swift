import SwiftUI

/// Style contract for FormItem molecule
public struct FormItemStyle: Equatable, Sendable {
    public let spacing: CGFloat
    
    public init(spacing: CGFloat) {
        self.spacing = spacing
    }
}
