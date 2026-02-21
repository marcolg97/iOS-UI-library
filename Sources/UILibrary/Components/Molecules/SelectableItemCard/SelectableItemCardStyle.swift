import SwiftUI

/// Style contract for `SelectableItemCard`.
public struct SelectableItemCardStyle: Equatable, Sendable {
    public let selectedIconBackgroundColor: Color
    public let unselectedIconBackgroundColor: Color
    public let selectedIconColor: Color
    public let unselectedIconColor: Color
    public let selectedTitleColor: Color
    public let unselectedTitleColor: Color
    public let subtitleColor: Color
    public let selectedIndicatorColor: Color
    public let unselectedIndicatorColor: Color
    public let selectedBackgroundColor: Color
    public let unselectedBackgroundColor: Color
    public let selectedBorderColor: Color
    public let unselectedBorderColor: Color
    public let cornerRadius: CGFloat
    public let padding: CGFloat
    public let selectedScale: CGFloat

    public init(
        selectedIconBackgroundColor: Color,
        unselectedIconBackgroundColor: Color,
        selectedIconColor: Color,
        unselectedIconColor: Color,
        selectedTitleColor: Color,
        unselectedTitleColor: Color,
        subtitleColor: Color,
        selectedIndicatorColor: Color,
        unselectedIndicatorColor: Color,
        selectedBackgroundColor: Color,
        unselectedBackgroundColor: Color,
        selectedBorderColor: Color,
        unselectedBorderColor: Color,
        cornerRadius: CGFloat = 20,
        padding: CGFloat = 16,
        selectedScale: CGFloat = 1.02
    ) {
        self.selectedIconBackgroundColor = selectedIconBackgroundColor
        self.unselectedIconBackgroundColor = unselectedIconBackgroundColor
        self.selectedIconColor = selectedIconColor
        self.unselectedIconColor = unselectedIconColor
        self.selectedTitleColor = selectedTitleColor
        self.unselectedTitleColor = unselectedTitleColor
        self.subtitleColor = subtitleColor
        self.selectedIndicatorColor = selectedIndicatorColor
        self.unselectedIndicatorColor = unselectedIndicatorColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unselectedBackgroundColor = unselectedBackgroundColor
        self.selectedBorderColor = selectedBorderColor
        self.unselectedBorderColor = unselectedBorderColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.selectedScale = selectedScale
    }
}
