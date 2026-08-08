//
//  SegmentedControlStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `SegmentedControlAtom`.
public struct SegmentedControlStyle: Equatable, Sendable {
    public let font: Font
    public let selectedFont: Font
    public let textColor: Color
    public let selectedTextColor: Color
    public let containerBackgroundColor: Color
    public let selectedBackgroundColor: Color
    public let containerCornerRadius: CGFloat
    public let segmentCornerRadius: CGFloat
    public let containerPadding: CGFloat
    public let segmentSpacing: CGFloat
    public let segmentVerticalPadding: CGFloat
    public let segmentHorizontalPadding: CGFloat
    /// Minimum control height (HIG recommends 44pt tap targets).
    public let minTapTarget: CGFloat

    public init(
        font: Font = .subheadline,
        selectedFont: Font = .subheadline.weight(.semibold),
        textColor: Color = .secondary,
        selectedTextColor: Color = .primary,
        containerBackgroundColor: Color = Color.primary.opacity(0.06),
        selectedBackgroundColor: Color = Color.primary.opacity(0.1),
        containerCornerRadius: CGFloat = 10,
        segmentCornerRadius: CGFloat = 8,
        containerPadding: CGFloat = 3,
        segmentSpacing: CGFloat = 2,
        segmentVerticalPadding: CGFloat = 8,
        segmentHorizontalPadding: CGFloat = 12,
        minTapTarget: CGFloat = 44
    ) {
        self.font = font
        self.selectedFont = selectedFont
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.containerBackgroundColor = containerBackgroundColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.containerCornerRadius = containerCornerRadius
        self.segmentCornerRadius = segmentCornerRadius
        self.containerPadding = containerPadding
        self.segmentSpacing = segmentSpacing
        self.segmentVerticalPadding = segmentVerticalPadding
        self.segmentHorizontalPadding = segmentHorizontalPadding
        self.minTapTarget = minTapTarget
    }
}
