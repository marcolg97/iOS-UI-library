//
//  WeekdayStatusStripStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

public extension WeekdayStatusStripStyle {
    static let `default`: WeekdayStatusStripStyle = .init(
        dayLabelColor: .primary.opacity(0.4),
        dayLabelFont: .body,
        captionFont: .footnote,
        completedBackground: .accentColor.opacity(0.3),
        highlightedBackground: .accentColor.opacity(0.1),
        upcomingRingColor: .primary.opacity(0.25),
        completedCheckmarkColor: .primary,
        containerBackgroundColor: .primary.opacity(0.05),
        containerBorderColor: .primary.opacity(0.1),
        highlightBorderColor: .accentColor.opacity(0.6),
        highlightBorderWidth: 2,
        completedCaptionColor: .primary,
        highlightedCaptionColor: .accentColor,
        upcomingCaptionColor: .primary.opacity(0.6)
    )
}
