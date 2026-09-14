import SwiftUI

/// Style contract for `QuantityStepper`.
///
/// - Responsibility: visual tokens for `QuantityStepper` (the two `ActionButton`s and the value
///   label between them). Immutable and brand-agnostic; apps should provide concrete tokens via
///   style factories.
public struct QuantityStepperStyle: Equatable, Sendable {
    /// Style applied to the decrement/increment buttons. Defaults to `ActionButtonStyle.iconCircle`,
    /// which already guarantees a 44pt tap target.
    public let buttonStyle: ActionButtonStyle

    /// Font used for the value label between the two buttons.
    public let valueFont: Font

    /// Color used for the value label.
    public let valueColor: Color

    /// Minimum width reserved for the value label, so the control doesn't reflow width as the
    /// number of digits changes (e.g. going from "9" to "10").
    public let valueMinWidth: CGFloat

    /// Horizontal spacing between the decrement button, value label, and increment button.
    public let spacing: CGFloat

    /// Opacity applied to the whole control when `isDisabled` is `true`.
    public let disabledOpacity: Double

    /// Creates a `QuantityStepperStyle`.
    /// - Parameters:
    ///   - buttonStyle: Style for the decrement/increment buttons (default: `.iconCircle`).
    ///   - valueFont: Font for the value label (default: `.body.weight(.semibold)`).
    ///   - valueColor: Color for the value label (default: `.primary`).
    ///   - valueMinWidth: Minimum width reserved for the value label (default: 28).
    ///   - spacing: Horizontal spacing between elements (default: 12).
    ///   - disabledOpacity: Opacity applied when disabled (default: 0.4).
    public init(
        buttonStyle: ActionButtonStyle = .iconCircle,
        valueFont: Font = .body.weight(.semibold),
        valueColor: Color = .primary,
        valueMinWidth: CGFloat = 28,
        spacing: CGFloat = 12,
        disabledOpacity: Double = 0.4
    ) {
        self.buttonStyle = buttonStyle
        self.valueFont = valueFont
        self.valueColor = valueColor
        self.valueMinWidth = valueMinWidth
        self.spacing = spacing
        self.disabledOpacity = disabledOpacity
    }
}
