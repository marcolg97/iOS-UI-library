import SwiftUI

/// A compact stepper for small integer quantities (portions, party size, cart quantity, …).
///
/// - Responsibility: presentational UI only — mutates a bound `Int` within `range` in `step`
///   increments. No business logic (persistence, validation beyond the range, etc).
/// - Layer: Atom (primitive UI component)
/// - Style: visual appearance injected via `QuantityStepperStyle`.
///
/// Built on `ActionButton.iconCircle` for the two controls, so it inherits the library's 44pt
/// minimum tap target and haptics-free, accessibility-first button behavior for free.
///
/// ## Accessibility
/// The whole control is exposed to VoiceOver as a single adjustable element (label + current
/// value, swipe up/down to increment/decrement) — the same pattern SwiftUI's own `Stepper` uses —
/// rather than as two separately-focusable buttons. This requires a required `accessibilityLabel`
/// describing what is being counted (e.g. "Portions"), since a bare number has no meaning on its own.
///
/// ## Usage
/// ```swift
/// QuantityStepper(
///     value: $portions,
///     accessibilityLabel: "Portions"
/// )
///
/// QuantityStepper(
///     value: $guestCount,
///     accessibilityLabel: "Guests",
///     range: 1...20,
///     style: .compact
/// )
/// ```
public struct QuantityStepper: View {
    @Binding private var value: Int
    private let accessibilityLabel: LocalizedStringResource
    private let range: ClosedRange<Int>
    private let step: Int
    private let isDisabled: Bool
    private let style: QuantityStepperStyle

    /// Creates a `QuantityStepper`.
    /// - Parameters:
    ///   - value: The bound quantity. Mutations are always clamped to `range`.
    ///   - accessibilityLabel: Required VoiceOver label describing what is being counted (e.g.
    ///     "Portions", "Guests") — the control has no visible label of its own.
    ///   - range: The allowed range for `value` (default: `0...99`).
    ///   - step: The amount each increment/decrement changes `value` by (default: 1).
    ///   - isDisabled: Disables both buttons and the adjustable accessibility action (default: `false`).
    ///   - style: Visual style for the control. Defaults to `.default`.
    public init(
        value: Binding<Int>,
        accessibilityLabel: LocalizedStringResource,
        range: ClosedRange<Int> = 0...99,
        step: Int = 1,
        isDisabled: Bool = false,
        style: QuantityStepperStyle = .default
    ) {
        self._value = value
        self.accessibilityLabel = accessibilityLabel
        self.range = range
        self.step = step
        self.isDisabled = isDisabled
        self.style = style
    }

    private var canDecrement: Bool { !isDisabled && value > range.lowerBound }
    private var canIncrement: Bool { !isDisabled && value < range.upperBound }

    private func decrement() {
        guard canDecrement else { return }
        value = Self.clampedValue(value, step: step, range: range, direction: .decrement)
    }

    private func increment() {
        guard canIncrement else { return }
        value = Self.clampedValue(value, step: step, range: range, direction: .increment)
    }

    /// Pure clamped-arithmetic backing `increment()`/`decrement()`, extracted so the stepping
    /// logic is deterministic and unit-testable without a running view.
    nonisolated static func clampedValue(
        _ value: Int,
        step: Int,
        range: ClosedRange<Int>,
        direction: AccessibilityAdjustmentDirection
    ) -> Int {
        switch direction {
        case .increment:
            return Swift.min(range.upperBound, value + step)
        case .decrement:
            return Swift.max(range.lowerBound, value - step)
        @unknown default:
            return value
        }
    }

    public var body: some View {
        HStack(spacing: style.spacing) {
            ActionButton(
                systemName: "minus",
                accessibilityLabel: LocalizedStringResource("Decrease", bundle: .atURL(Bundle.module.bundleURL)),
                isEnabled: canDecrement,
                style: style.buttonStyle,
                action: decrement
            )

            Text(value, format: .number)
                .font(style.valueFont)
                .foregroundStyle(style.valueColor)
                .monospacedDigit()
                .frame(minWidth: style.valueMinWidth)
                .fixedSize()

            ActionButton(
                systemName: "plus",
                accessibilityLabel: LocalizedStringResource("Increase", bundle: .atURL(Bundle.module.bundleURL)),
                isEnabled: canIncrement,
                style: style.buttonStyle,
                action: increment
            )
        }
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(accessibilityLabel))
        .accessibilityValue(Text(value, format: .number))
        .accessibilityAddTraits(isDisabled ? [] : .isButton)
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                increment()
            case .decrement:
                decrement()
            @unknown default:
                break
            }
        }
    }
}

#if DEBUG
#Preview("QuantityStepper") {
    @Previewable @State var portions = 3
    @Previewable @State var guests = 0
    @Previewable @State var disabled = 5

    PreviewContainer {
        PreviewSection("Default") {
            QuantityStepper(value: $portions, accessibilityLabel: .verbatim("Portions"))
        }

        PreviewSection("At lower bound (0...9)") {
            QuantityStepper(value: $guests, accessibilityLabel: .verbatim("Guests"), range: 0...9)
        }

        PreviewSection("Step of 2, range 0...20") {
            QuantityStepper(value: $portions, accessibilityLabel: .verbatim("Portions"), range: 0...20, step: 2)
        }

        PreviewSection("Disabled") {
            QuantityStepper(value: $disabled, accessibilityLabel: .verbatim("Portions"), isDisabled: true)
        }

        PreviewSection("Compact style") {
            QuantityStepper(value: $portions, accessibilityLabel: .verbatim("Portions"), style: .compact)
        }
    }
}
#endif
