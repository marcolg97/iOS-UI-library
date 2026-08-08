//
//  CircularProgressBar.swift
//  UILibrary
//
//  Created by Marco La Gala on 15/02/26.
//

import SwiftUI

public struct CircularProgressBar: View {
    public let progress: Double // 0.0 to 1.0
    public let style: CircularProgressBarStyle

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        progress: Double,
        style: CircularProgressBarStyle = .default
    ) {
        self.progress = progress
        self.style = style
    }

    public var body: some View {
        ZStack {
            // Background Track
            Circle()
                .stroke(style.trackColor, lineWidth: style.lineWidth)

            // Progress Fill
            Circle()
                .trim(from: 0, to: CGFloat(normalizedProgress))
                .stroke(
                    LinearGradient(
                        colors: style.progressGradientColors,
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: style.lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .overlay(
                    // Shine effect layered on the same arc
                    Circle()
                        .trim(from: 0, to: CGFloat(normalizedProgress))
                        .stroke(
                            LinearGradient(
                                colors: style.shineGradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: style.lineWidth / 2, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                )
                .animation(reduceMotion ? nil : progressAnimation, value: normalizedProgress)

            if style.showPercentageLabel {
                Text(verbatim: "\(percentage)%")
                    .font(.system(size: style.size * 0.25, weight: .bold, design: .rounded))
                    .foregroundStyle(style.textColor)
            }
        }
        .frame(width: style.size, height: style.size)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Progress", bundle: .module))
        .accessibilityValue(Text(verbatim: "\(percentage)%"))
    }

    private var normalizedProgress: Double {
        min(max(progress, 0), 1)
    }

    private var percentage: Int {
        Int((normalizedProgress * 100).rounded())
    }

    private var progressAnimation: Animation {
        .spring(
            response: style.progressAnimationResponse,
            dampingFraction: style.progressAnimationDampingFraction
        )
    }
}

#if DEBUG
#Preview {
    CircularProgressBar(
        progress: 0.65,
        style: .init(
            trackColor: .primary.opacity(0.1),
            progressGradientColors: [.accentColor, .accentColor.opacity(0.7)],
            shineGradientColors: [.white.opacity(0.4), .clear],
            textColor: .primary,
            size: 100,
            lineWidth: 12
        )
    )
}
#endif
