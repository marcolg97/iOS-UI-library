//
//  CircularProgressBarStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Style contract for `CircularProgressBar`.
public struct CircularProgressBarStyle: Equatable, Sendable {
    public let trackColor: Color
    public let progressGradientColors: [Color]
    public let shineGradientColors: [Color]
    public let textColor: Color
    public let showPercentageLabel: Bool
    public let progressAnimationResponse: Double
    public let progressAnimationDampingFraction: Double

    public init(
        trackColor: Color,
        progressGradientColors: [Color],
        shineGradientColors: [Color],
        textColor: Color,
        showPercentageLabel: Bool = true,
        progressAnimationResponse: Double = 0.6,
        progressAnimationDampingFraction: Double = 0.7
    ) {
        self.trackColor = trackColor
        self.progressGradientColors = progressGradientColors
        self.shineGradientColors = shineGradientColors
        self.textColor = textColor
        self.showPercentageLabel = showPercentageLabel
        self.progressAnimationResponse = progressAnimationResponse
        self.progressAnimationDampingFraction = progressAnimationDampingFraction
    }
}
