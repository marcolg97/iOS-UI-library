import SwiftUI

/// Style contract for `SelectableItemCard`.
public struct SelectableItemCardStyle: Equatable, Sendable {
    public let selectedIndicatorColor: Color
    public let unselectedIndicatorColor: Color
    public let selectedBackgroundColor: Color
    public let unselectedBackgroundColor: Color
    public let selectedBorderColor: Color
    public let unselectedBorderColor: Color
    public let selectedIndicatorSystemName: String
    public let unselectedIndicatorSystemName: String
    public let indicatorFont: Font
    public let contentSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let padding: CGFloat
    public let selectedScale: CGFloat

    public init(
        selectedIndicatorColor: Color,
        unselectedIndicatorColor: Color,
        selectedBackgroundColor: Color,
        unselectedBackgroundColor: Color,
        selectedBorderColor: Color,
        unselectedBorderColor: Color,
        selectedIndicatorSystemName: String = "checkmark.circle.fill",
        unselectedIndicatorSystemName: String = "circle",
        indicatorFont: Font = .title2,
        contentSpacing: CGFloat = 16,
        cornerRadius: CGFloat = 20,
        padding: CGFloat = 16,
        selectedScale: CGFloat = 1.02
    ) {
        self.selectedIndicatorColor = selectedIndicatorColor
        self.unselectedIndicatorColor = unselectedIndicatorColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unselectedBackgroundColor = unselectedBackgroundColor
        self.selectedBorderColor = selectedBorderColor
        self.unselectedBorderColor = unselectedBorderColor
        self.selectedIndicatorSystemName = selectedIndicatorSystemName
        self.unselectedIndicatorSystemName = unselectedIndicatorSystemName
        self.indicatorFont = indicatorFont
        self.contentSpacing = contentSpacing
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.selectedScale = selectedScale
    }
}
