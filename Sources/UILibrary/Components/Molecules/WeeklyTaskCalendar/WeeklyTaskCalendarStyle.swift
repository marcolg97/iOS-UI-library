//
//  WeeklyTaskCalendarStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Style contract for `WeeklyTaskCalendar`.
public struct WeeklyTaskCalendarStyle: Equatable, Sendable {
    public let dayLabelColor: Color
    public let dayLabelFont: Font
    public let statusTextFont: Font
    public let completedBackground: Color
    public let plannedBackground: Color
    public let upcomingRingColor: Color
    public let completedCheckmarkColor: Color
    public let containerBackgroundColor: Color
    public let containerBorderColor: Color
    public let containerCornerRadius: CGFloat
    public let containerPadding: CGFloat
    public let dayCircleSize: CGFloat
    public let daySpacing: CGFloat
    public let highlightBorderColor: Color
    public let highlightBorderWidth: CGFloat
    public let completedStatusTextColor: Color
    public let plannedStatusTextColor: Color
    public let upcomingStatusTextColor: Color

    public init(
        dayLabelColor: Color,
        dayLabelFont: Font,
        statusTextFont: Font,
        completedBackground: Color,
        plannedBackground: Color,
        upcomingRingColor: Color,
        completedCheckmarkColor: Color,
        containerBackgroundColor: Color,
        containerBorderColor: Color,
        highlightBorderColor: Color,
        highlightBorderWidth: CGFloat,
        completedStatusTextColor: Color,
        plannedStatusTextColor: Color,
        upcomingStatusTextColor: Color,
        containerCornerRadius: CGFloat = 24,
        containerPadding: CGFloat = 20,
        dayCircleSize: CGFloat = 36,
        daySpacing: CGFloat = 12
    ) {
        self.dayLabelColor = dayLabelColor
        self.dayLabelFont = dayLabelFont
        self.statusTextFont = statusTextFont
        self.completedBackground = completedBackground
        self.plannedBackground = plannedBackground
        self.upcomingRingColor = upcomingRingColor
        self.completedCheckmarkColor = completedCheckmarkColor
        self.containerBackgroundColor = containerBackgroundColor
        self.containerBorderColor = containerBorderColor
        self.containerCornerRadius = containerCornerRadius
        self.containerPadding = containerPadding
        self.dayCircleSize = dayCircleSize
        self.daySpacing = daySpacing
        self.highlightBorderColor = highlightBorderColor
        self.highlightBorderWidth = highlightBorderWidth
        self.completedStatusTextColor = completedStatusTextColor
        self.plannedStatusTextColor = plannedStatusTextColor
        self.upcomingStatusTextColor = upcomingStatusTextColor
    }
}
