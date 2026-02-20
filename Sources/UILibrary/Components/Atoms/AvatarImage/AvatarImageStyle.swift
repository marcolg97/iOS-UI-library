import SwiftUI

/// Visual tokens describing how an `AvatarImage` should render.
///
/// The style is completely agnostic to business logic; it simply declares
/// the circular diameter, background color, typography for the initial
/// fallback, and optional border tokens. Applications build or obtain
/// concrete styles (typically from a theme/style factory) and pass them
/// down to the view.
///
/// Styles are immutable and `Equatable` so they can be compared in tests
/// or reused across multiple components without duplication.
public struct AvatarImageStyle: Equatable, Sendable {
    /// Diameter of the avatar circle.
    public let size: CGFloat

    /// Background color used when an image isn't supplied or to sit behind
    /// the image.
    public let backgroundColor: Color

    /// Font used for the fallback initial.
    public let font: Font

    /// Color of the fallback initial text.
    public let textColor: Color

    /// Optional stroke drawn around the circle.
    public let borderColor: Color?
    public let borderWidth: CGFloat

    /// Creates a new `AvatarImageStyle`.
    ///
    /// - Parameters:
    ///   - size: Diameter of the avatar (default: 40).
    ///   - backgroundColor: Circle fill color (default: secondary system background).
    ///   - font: Font for the initial text (default: `.headline`).
    ///   - textColor: Color for the initial (default: `.white`).
    ///   - borderColor: Optional stroke color (nil = no border).
    ///   - borderWidth: Width of the border stroke (default: 1).
    public init(
        size: CGFloat = 40,
        backgroundColor: Color = Color.secondary.opacity(0.2),
        font: Font = .headline,
        textColor: Color = .white,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 1
    ) {
        self.size = size
        self.backgroundColor = backgroundColor
        self.font = font
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}
