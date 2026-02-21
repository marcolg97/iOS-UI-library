//
//  CircularProgressBar.swift
//  UILibrary
//
//  Created by Marco La Gala on 15/02/26.
//

import SwiftUI

public struct CircularProgressBar: View {
    public let progress: Double // 0.0 to 1.0
    public let size: CGFloat
    public let lineWidth: CGFloat
    public let style: CircularProgressBarStyle
    
    public init(
        progress: Double,
        size: CGFloat = 60,
        lineWidth: CGFloat = 8,
        style: CircularProgressBarStyle = .default
    ) {
        self.progress = progress
        self.size = size
        self.lineWidth = lineWidth
        self.style = style
    }
    
    public var body: some View {
        ZStack {
            // Background Track
            Circle()
                .stroke(style.trackColor, lineWidth: lineWidth)
                .frame(width: size, height: size)
            
            // Progress Fill
            Circle()
                .trim(from: 0, to: CGFloat(normalizedProgress))
                .stroke(
                    LinearGradient(
                        colors: style.progressGradientColors,
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .animation(progressAnimation, value: normalizedProgress)
                .overlay(
                    // Shine effect (radial-ish)
                    Circle()
                        .trim(from: 0, to: CGFloat(normalizedProgress))
                        .stroke(
                            LinearGradient(
                                colors: style.shineGradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: lineWidth / 2, lineCap: .round)
                        )
                        .frame(width: size - (lineWidth / 2), height: size - (lineWidth / 2))
                        .rotationEffect(.degrees(-90))
                        .padding(lineWidth / 4)
                        .animation(progressAnimation, value: normalizedProgress)
                )
            
            if style.showPercentageLabel {
                Text("\(Int(normalizedProgress * 100))%")
                    .font(.system(size: size * 0.25, weight: .bold, design: .rounded))
                    .foregroundStyle(style.textColor)
            }
        }
    }

    private var normalizedProgress: Double {
        min(max(progress, 0), 1)
    }

    private var progressAnimation: Animation {
        .spring(
            response: style.progressAnimationResponse,
            dampingFraction: style.progressAnimationDampingFraction
        )
    }
}

#Preview {
    CircularProgressBar(progress: 0.65, size: 100, lineWidth: 12)
}
