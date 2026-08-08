//
//  WeekdayStatusStripStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Style contract for `WeekdayStatusStrip`.
public struct WeekdayStatusStripStyle: Equatable, Sendable {
    public let dayLabelColor: Color
    public let dayLabelFont: Font
    public let captionFont: Font
    public let completedBackground: Color
    public let highlightedBackground: Color
    public let upcomingBackground: Color
    public let upcomingRingColor: Color
    public let upcomingRingWidth: CGFloat
    public let completedCheckmarkColor: Color
    public let containerBackgroundColor: Color
    public let containerBorderColor: Color
    public let containerCornerRadius: CGFloat
    public let containerPadding: CGFloat
    public let dayCircleSize: CGFloat
    public let daySpacing: CGFloat
    public let dayContentSpacing: CGFloat
    public let highlightBorderColor: Color
    public let highlightBorderWidth: CGFloat
    public let completedCaptionColor: Color
    public let highlightedCaptionColor: Color
    public let upcomingCaptionColor: Color

    public init(
        dayLabelColor: Color,
        dayLabelFont: Font,
        captionFont: Font,
        completedBackground: Color,
        highlightedBackground: Color,
        upcomingBackground: Color = .clear,
        upcomingRingColor: Color,
        upcomingRingWidth: CGFloat = 2,
        completedCheckmarkColor: Color,
        containerBackgroundColor: Color,
        containerBorderColor: Color,
        highlightBorderColor: Color,
        highlightBorderWidth: CGFloat,
        completedCaptionColor: Color,
        highlightedCaptionColor: Color,
        upcomingCaptionColor: Color,
        containerCornerRadius: CGFloat = 24,
        containerPadding: CGFloat = 20,
        dayCircleSize: CGFloat = 36,
        daySpacing: CGFloat = 12,
        dayContentSpacing: CGFloat = 8
    ) {
        self.dayLabelColor = dayLabelColor
        self.dayLabelFont = dayLabelFont
        self.captionFont = captionFont
        self.completedBackground = completedBackground
        self.highlightedBackground = highlightedBackground
        self.upcomingBackground = upcomingBackground
        self.upcomingRingColor = upcomingRingColor
        self.upcomingRingWidth = upcomingRingWidth
        self.completedCheckmarkColor = completedCheckmarkColor
        self.containerBackgroundColor = containerBackgroundColor
        self.containerBorderColor = containerBorderColor
        self.containerCornerRadius = containerCornerRadius
        self.containerPadding = containerPadding
        self.dayCircleSize = dayCircleSize
        self.daySpacing = daySpacing
        self.dayContentSpacing = dayContentSpacing
        self.highlightBorderColor = highlightBorderColor
        self.highlightBorderWidth = highlightBorderWidth
        self.completedCaptionColor = completedCaptionColor
        self.highlightedCaptionColor = highlightedCaptionColor
        self.upcomingCaptionColor = upcomingCaptionColor
    }
}
