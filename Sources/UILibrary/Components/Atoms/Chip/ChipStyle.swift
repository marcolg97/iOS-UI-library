//
//  ChipStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `Chip`.
public struct ChipStyle: Equatable, Sendable {
    public let font: Font
    public let textColor: Color
    public let selectedTextColor: Color
    public let backgroundColor: Color
    public let selectedBackgroundColor: Color
    public let borderColor: Color
    public let selectedBorderColor: Color
    public let borderWidth: CGFloat
    public let spacing: CGFloat
    public let verticalPadding: CGFloat
    public let horizontalPadding: CGFloat
    public let removeIconSystemName: String
    /// Minimum tap-target height for interactive chips (HIG recommends 44pt).
    public let minTapTarget: CGFloat

    public init(
        font: Font = .subheadline,
        textColor: Color = .primary,
        selectedTextColor: Color = .white,
        backgroundColor: Color = Color.primary.opacity(0.06),
        selectedBackgroundColor: Color = .accentColor,
        borderColor: Color = Color.primary.opacity(0.12),
        selectedBorderColor: Color = .clear,
        borderWidth: CGFloat = 1,
        spacing: CGFloat = 6,
        verticalPadding: CGFloat = 6,
        horizontalPadding: CGFloat = 12,
        removeIconSystemName: String = "xmark.circle.fill",
        minTapTarget: CGFloat = 44
    ) {
        self.font = font
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.backgroundColor = backgroundColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.borderColor = borderColor
        self.selectedBorderColor = selectedBorderColor
        self.borderWidth = borderWidth
        self.spacing = spacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.removeIconSystemName = removeIconSystemName
        self.minTapTarget = minTapTarget
    }
}
