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

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

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

    // MARK: - Shared fill helpers

    private var fillShapeStyle: AnyShapeStyle {
        if let start = style.progressGradientStartColor, let end = style.progressGradientEndColor {
            return AnyShapeStyle(LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing))
        }
        return AnyShapeStyle(style.progressColor)
    }

    /// Progress capsule with optional 3D gloss/glow decorations.
    @ViewBuilder
    private func fillCapsule(width: CGFloat?) -> some View {
        Capsule()
            .fill(fillShapeStyle)
            .frame(width: width, height: style.height)
            .shadow(
                color: style.threeDConfig?.glowColor ?? .clear,
                radius: style.threeDConfig?.shadowRadius ?? 0,
                x: 0, y: 0
            )
            .overlay {
                if let threeD = style.threeDConfig {
                    Capsule()
                        .fill(threeD.highlightColor)
                        .frame(height: max(1, style.height * 0.45))
                        .offset(y: -style.height * 0.20)
                        .opacity(0.85)
                        .blendMode(.screen)
                }
            }
    }

    // MARK: - Continuous (determinate / indeterminate)

    @ViewBuilder
    private func determinateOrIndeterminateBody() -> some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(style.trackColor)
                    .frame(height: style.height)

                if let v = value {
                    fillCapsule(width: max(0, min(1, v)) * geo.size.width)
                } else if reduceMotion {
                    // Static representation when the user prefers reduced motion.
                    fillCapsule(width: geo.size.width * 0.6)
                        .opacity(0.6)
                } else {
                    // TimelineView derives the sweep offset from the clock, so the
                    // animation survives view rebuilds without any @State.
                    TimelineView(.animation) { context in
                        let duration = max(0.1, style.indeterminateAnimationDuration)
                        let elapsed = context.date.timeIntervalSinceReferenceDate
                        let progress = elapsed.truncatingRemainder(dividingBy: duration) / duration
                        let offset = -0.6 + progress * 1.7

                        fillCapsule(width: geo.size.width * 0.6)
                            .offset(x: geo.size.width * offset)
                    }
                }
            }
            .frame(height: style.height)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
        }
        .frame(height: style.height)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Progress", bundle: .module))
        .accessibilityValue(accessibilityValue)
        .accessibilityAddTraits(value == nil ? .updatesFrequently : [])
    }

    // MARK: - Segmented

    @ViewBuilder
    private func segmentedBody(current: Int, total: Int) -> some View {
        let cfg = style.segmentedConfig
        HStack(spacing: cfg.spacing) {
            ForEach(Array(1...total), id: \.self) { step in
                let width = step == current ? cfg.activeWidth : cfg.inactiveWidth

                if step <= current {
                    fillCapsule(width: width)
                } else {
                    Capsule()
                        .fill(style.trackColor)
                        .frame(width: width, height: style.height)
                }
            }

            Spacer()

            Text("Step \(current)/\(total)", bundle: .module)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(cfg.textColor ?? .secondary)
        }
        .frame(height: max(style.height, 20))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Progress", bundle: .module))
        .accessibilityValue(Text("Step \(current) of \(total)", bundle: .module))
    }

    private var accessibilityValue: Text {
        if let v = value {
            let percent = Int((max(0, min(1, v)) * 100).rounded())
            return Text(verbatim: "\(percent)%")
        }
        return Text("In progress", bundle: .module)
    }
}

#if DEBUG
#Preview("ProgressBar · Determinate / Indeterminate / Segmented") {
    VStack(spacing: 16) {
        ProgressBar(value: 0.5, style: .accent)
            .frame(height: 8)

        Text(verbatim: "Indeterminate")
            .font(.caption)
            .foregroundStyle(.gray)
        ProgressBar(style: .accent)
            .frame(height: 6)
            .frame(maxWidth: 300)

        Text(verbatim: "Segmented (onboarding style)")
            .font(.caption)
            .foregroundStyle(.gray)

        ProgressBar(currentStep: 2, totalSteps: 4, style: .neutral)
            .frame(maxWidth: 360)

        ProgressBar(currentStep: 2, totalSteps: 4, style: .threeD)
            .frame(maxWidth: 360)

        Text(verbatim: "3D / Glossy")
            .font(.caption)
            .foregroundStyle(.gray)

        ProgressBar(value: 0.65, style: .threeD)
            .frame(height: 10)
            .frame(maxWidth: 360)

        ProgressBar(
            value: 0.25,
            style: .bold
        )
        .frame(height: 6)
    }
    .padding()
}

#Preview("ProgressBar Animation") {
    @Previewable @State var value: Double = 0.05

    ProgressBar(
        value: value,
        style: .bold
    )

    Button {
        withAnimation {
            value = min(1, value + 0.1)
        }
    } label: {
        Text(verbatim: "Go next")
    }
}
#endif
