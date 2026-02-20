import SwiftUI

/// Visual tokens describing how a `Badge` should render.
///
/// The style is completely agnostic to business logic; it simply declares
/// colors, typography, padding, corner radius, and optional border tokens.
/// Applications build or obtain concrete styles (typically from a theme/style
/// factory) and pass them down to the view.
///
/// Styles are immutable and `Equatable` so they can be compared in tests
/// or reused across multiple components without duplication.
public struct BadgeStyle: Equatable, Sendable {
    /// Background color of the badge.
    public let backgroundColor: Color
    
    /// Text color of the badge.
    public let foregroundColor: Color
    
    /// Font used for badge text.
    public let font: Font
    
    /// Vertical padding (top and bottom).
    public let verticalPadding: CGFloat
    
    /// Horizontal padding (leading and trailing).
    public let horizontalPadding: CGFloat
    
    /// Corner radius of the badge background.
    public let cornerRadius: CGFloat
    
    /// Optional stroke color. When `nil`, no border is drawn.
    public let borderColor: Color?
    
    /// Border width. Only applied when `borderColor` is non-nil.
    public let borderWidth: CGFloat

    /// Creates a new `BadgeStyle`.
    ///
    /// - Parameters:
    ///   - backgroundColor: Background color (default: primary with 12% opacity).
    ///   - foregroundColor: Text color (default: primary).
    ///   - font: Badge font (default: `.caption`).
    ///   - verticalPadding: Vertical padding top/bottom (default: 4pt).
    ///   - horizontalPadding: Horizontal padding leading/trailing (default: 8pt).
    ///   - cornerRadius: Corner radius of background (default: 8pt).
    ///   - borderColor: Optional border color (nil = no border).
    ///   - borderWidth: Border width (default: 0).
    public init(
        backgroundColor: Color = Color.primary.opacity(0.12),
        foregroundColor: Color = Color.primary,
        font: Font = .caption,
        verticalPadding: CGFloat = 4,
        horizontalPadding: CGFloat = 8,
        cornerRadius: CGFloat = 8,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}

