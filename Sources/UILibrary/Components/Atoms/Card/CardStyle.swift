import SwiftUI

/// Style contract for `Card`.
///
/// - Responsibility: Visual tokens for `Card` (background, corner radius, padding, shadow).
/// - Note: Immutable and brand-agnostic; apps should provide concrete colors via style factories.
public struct CardStyle: Equatable, Sendable {
    public let backgroundColor: Color?
    public let cornerRadius: CGFloat
    public let padding: CGFloat
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    public let shadowX: CGFloat
    public let shadowY: CGFloat

    /// Creates a `CardStyle`.
    /// - Parameters:
    ///   - backgroundColor: Optional surface color for the card.
    ///   - cornerRadius: Corner radius for the card surface.
    ///   - padding: Internal content padding.
    ///   - shadowColor: Shadow color.
    ///   - shadowRadius: Shadow blur radius.
    ///   - shadowX: Horizontal shadow offset.
    ///   - shadowY: Vertical shadow offset.
    public init(
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat = 12,
        padding: CGFloat = 12,
        shadowColor: Color = .black.opacity(0.1),
        shadowRadius: CGFloat = 2,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 1
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
    }
}
