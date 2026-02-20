import SwiftUI

/// Style contract for `ActionButton`.
///
/// Responsibility: visual tokens for `ActionButton` (colors, typography, corner radius, padding,
/// shadow and tap-target). Styles are immutable and brand‑agnostic — apps should provide concrete
/// tokens via style factories.
public struct ActionButtonStyle: Equatable, Sendable {
    public let backgroundColor: Color
    public let foregroundColor: Color
    public let disabledBackgroundColor: Color
    public let disabledForegroundColor: Color
    public let borderColor: Color?
    /// Optional stroke color to use when the button is disabled. When `nil` we fall back to `borderColor`.
    public let disabledBorderColor: Color?
    public let font: Font
    public let cornerRadius: CGFloat
    public let verticalPadding: CGFloat
    public let horizontalPadding: CGFloat
    public let minTapTarget: CGSize
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    public let shadowYOffset: CGFloat
    /// Default maximum width for the button. `nil` means intrinsic/content width; use `.infinity` to expand.
    public let defaultMaxWidth: CGFloat?

    /// Creates an `ActionButtonStyle`.
    /// - Parameter defaultMaxWidth: Optional default `maxWidth` applied to the button. If `nil` the button sizes to its content.
    public init(
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .white,
        disabledBackgroundColor: Color = Color.primary.opacity(0.12),
        disabledForegroundColor: Color = Color.primary.opacity(0.6),
        borderColor: Color? = nil,
        disabledBorderColor: Color? = nil,
        font: Font = .body.weight(.semibold),
        cornerRadius: CGFloat = 12,
        verticalPadding: CGFloat = 12,
        horizontalPadding: CGFloat = 16,
        minTapTarget: CGSize = CGSize(width: 44, height: 44),
        shadowColor: Color = Color.black.opacity(0.12),
        shadowRadius: CGFloat = 6,
        shadowYOffset: CGFloat = 4,
        defaultMaxWidth: CGFloat? = .infinity
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
        self.disabledForegroundColor = disabledForegroundColor
        self.borderColor = borderColor
        self.disabledBorderColor = disabledBorderColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.minTapTarget = minTapTarget
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowYOffset = shadowYOffset
        self.defaultMaxWidth = defaultMaxWidth
    }
    
    func removePadding() -> Self {
        .init(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor: disabledBackgroundColor,
            disabledForegroundColor: disabledForegroundColor,
            borderColor: borderColor,
            disabledBorderColor: disabledBorderColor,
            font: font,
            cornerRadius: cornerRadius,
            verticalPadding: 0,
            horizontalPadding: 0,
            minTapTarget: minTapTarget,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius,
            shadowYOffset: shadowYOffset,
            defaultMaxWidth: defaultMaxWidth
        )
    }
}
