import SwiftUI

/// A lightweight, style-driven progress bar supporting three presentation modes:
/// - determinate (`value: Double` in 0...1),
/// - indeterminate (`value == nil`),
/// - step/segmented (`currentStep` + `totalSteps`) — useful for onboarding flows.
///
/// Responsibility: presentational progress indicator (no business logic). Use `ProgressBarStyle` to
/// control visual tokens. The segmented variant picks its colors and sizing from `ProgressBarStyle`.
///
/// Usage:
/// ```swift
/// ProgressBar(value: 0.6, style: .neutral)        // determinate — callers may animate changes with `withAnimation` or rely on implicit animations
/// ProgressBar(style: .neutral)                   // indeterminate
/// ProgressBar(currentStep: 2, totalSteps: 4)     // segmented (onboarding)
/// ```
public struct ProgressBar: View {
    private let value: Double?
    private let currentStep: Int?
    private let totalSteps: Int?
    private let style: ProgressBarStyle
    
    @State private var indeterminateOffset: CGFloat = -0.6
    
    /// Determinate or indeterminate initializer. When `value` is `nil` the component shows an indeterminate animation.
    public init(value: Double? = nil, style: ProgressBarStyle = .neutral) {
        self.value = value
        self.currentStep = nil
        self.totalSteps = nil
        self.style = style
    }
    
    /// Segmented/step-based initializer used by onboarding flows.
    /// - Parameters:
    ///   - currentStep: 1-based current step index.
    ///   - totalSteps: total number of steps (must be >= 1).
    ///   - style: `ProgressBarStyle` which provides segment visual tokens.
    public init(currentStep: Int, totalSteps: Int, style: ProgressBarStyle = .neutral) {
        self.value = nil
        self.currentStep = max(1, currentStep)
        self.totalSteps = max(1, totalSteps)
        self.style = style
    }
    
    public var body: some View {
        if let current = currentStep, let total = totalSteps {
            segmentedBody(current: current, total: total)
        } else {
            determinateOrIndeterminateBody()
        }
    }
    
    @ViewBuilder
    private func determinateOrIndeterminateBody() -> some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(style.trackColor)
                    .frame(height: style.height)
                
                if let v = value {
                    // determinate — choose gradient fill when 3D tokens are present, otherwise solid color.
                    let width = max(0, min(1, v)) * geo.size.width

                    if let start = style.progressGradientStartColor, let end = style.progressGradientEndColor {
                        Capsule()
                            .fill(LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing))
                            .frame(width: width, height: style.height)
                            .shadow(color: style.progressGlowColor ?? .clear, radius: style.progressShadowRadius, x: 0, y: 0)
                            .overlay(
                                Capsule()
                                    .fill(LinearGradient(colors: [style.progressHighlightColor ?? Color.white.opacity(0), Color.white.opacity(0)], startPoint: .top, endPoint: .bottom))
                                    .opacity(style.progressHighlightColor != nil ? 0.6 : 0)
                            )
                    } else {
                        Capsule()
                            .fill(style.progressColor)
                            .frame(width: width, height: style.height)
                    }
                } else {
                    if let start = style.progressGradientStartColor, let end = style.progressGradientEndColor {
                        Capsule()
                            .fill(LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing))
                            .frame(width: geo.size.width * 0.6, height: style.height)
                            .shadow(color: style.progressGlowColor ?? .clear, radius: style.progressShadowRadius, x: 0, y: 0)
                            .offset(x: geo.size.width * indeterminateOffset)
                            .onAppear {
                                withAnimation(.linear(duration: style.indeterminateAnimationDuration).repeatForever(autoreverses: false)) {
                                    indeterminateOffset = 1.1
                                }
                            }
                    } else {
                        Capsule()
                            .fill(style.progressColor.opacity(0.9))
                            .frame(width: geo.size.width * 0.6, height: style.height)
                            .offset(x: geo.size.width * indeterminateOffset)
                            .onAppear {
                                withAnimation(.linear(duration: style.indeterminateAnimationDuration).repeatForever(autoreverses: false)) {
                                    indeterminateOffset = 1.1
                                }
                            }
                    }
                }
            }
            .frame(height: style.height)
            .cornerRadius(style.cornerRadius)
            .accessibilityValue(accessibilityValue)
        }
        .frame(height: style.height)
    }
    
    @ViewBuilder
    private func segmentedBody(current: Int, total: Int) -> some View {
        HStack(spacing: style.segmentSpacing) {
            ForEach(1...total, id: \.self) { step in
                let isActive = step <= current
                let width = step == current ? style.segmentActiveWidth : style.segmentInactiveWidth

                if isActive, let start = style.progressGradientStartColor, let end = style.progressGradientEndColor {
                    Capsule()
                        .fill(LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing))
                        .frame(width: width, height: style.height)
                        .shadow(color: style.progressGlowColor ?? .clear, radius: style.progressShadowRadius, x: 0, y: 0)
                        .overlay(
                            Capsule()
                                .fill(LinearGradient(colors: [style.progressHighlightColor ?? Color.white.opacity(0), Color.white.opacity(0)], startPoint: .top, endPoint: .bottom))
                                .opacity(style.progressHighlightColor != nil ? 0.6 : 0)
                        )
                } else {
                    Capsule()
                        .fill(segmentFillColor(for: step, current: current))
                        .frame(width: width, height: style.height)
                }
            }
            
            Spacer()
            
            Text("Step \(current)/\(total)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.primary.opacity(0.6))
        }
        .frame(height: max(style.height, 20))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("Progress"))
        .accessibilityValue(Text("Step \(current) of \(total)"))
    }
    
    private func segmentFillColor(for step: Int, current: Int) -> Color {
        if step <= current {
            return style.segmentActiveColor ?? style.progressColor
        } else {
            return style.segmentInactiveColor ?? style.trackColor
        }
    }
    
    private var accessibilityValue: Text {
        if let v = value {
            return Text(String(format: "%.0f%%", v * 100))
        } else {
            return Text("In progress")
        }
    }
}

#Preview("ProgressBar · Determinate / Indeterminate / Segmented") {
    VStack(spacing: 16) {
        ProgressBar(value: 0.25, style: .init(progressColor: .green, height: 20))
            .frame(height: 6)
        
        ProgressBar(value: 0.5, style: .accent)
            .frame(height: 8)
        
        Text("Indeterminate")
            .font(.caption)
            .foregroundColor(.gray)
        ProgressBar(style: .accent)
            .frame(height: 6)
            .frame(maxWidth: 300)
        
        Text("Segmented (onboarding style)")
            .font(.caption)
            .foregroundColor(.gray)
        ProgressBar(currentStep: 2, totalSteps: 4, style: .neutral)
            .frame(maxWidth: 360)

        Text("3D / Glossy")
            .font(.caption)
            .foregroundColor(.gray)
        ProgressBar(value: 0.65, style: .threeD)
            .frame(height: 10)
            .frame(maxWidth: 360)
    }
    .padding()
}

#Preview("ProgressView Animation") {
    @Previewable @State var value: Double = 0
    
    ProgressBar(value: value, style: .init(progressColor: .green, height: 20))

    Button {
        value += 0.1
    } label: {
        Text("Go next")
    }
}
