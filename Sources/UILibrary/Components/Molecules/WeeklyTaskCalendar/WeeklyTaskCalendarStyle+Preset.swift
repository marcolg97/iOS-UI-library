//
//  WeeklyTaskCalendarStyle+Preset.swift
//  ios-ui-library
//
//  Created by Marco La Gala on 21/02/26.
//

import Foundation

public extension WeeklyTaskCalendarStyle {
    static let `default`: WeeklyTaskCalendarStyle = .init(
        dayLabelColor: .primary.opacity(0.4),
        dayLabelFont: .body,
        statusTextFont: .footnote,
        completedBackground: .cyan.opacity(0.3),
        plannedBackground: .cyan.opacity(0.1),
        upcomingRingColor: .primary.opacity(0.25),
        completedCheckmarkColor: .primary,
        containerBackgroundColor: .primary.opacity(0.05),
        containerBorderColor: .primary.opacity(0.1),
        highlightBorderColor: .cyan.opacity(0.6),
        highlightBorderWidth: 2,
        completedStatusTextColor: .primary,
        plannedStatusTextColor: .cyan,
        upcomingStatusTextColor: .primary.opacity(0.6)
    )
}
