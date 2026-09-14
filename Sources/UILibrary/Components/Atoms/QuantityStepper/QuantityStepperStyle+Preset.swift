import SwiftUI

public extension QuantityStepperStyle {
    /// Default preset — regular-sized `iconCircle` buttons with generous spacing.
    static let `default` = QuantityStepperStyle()

    /// Compact preset — tighter spacing and a narrower value label, for dense rows (list items,
    /// table cells). The buttons themselves still keep the library's 44pt minimum tap target
    /// (`ActionButtonStyle.iconCircle`); only the *visual* density around them changes.
    static let compact = QuantityStepperStyle(
        valueFont: .callout.weight(.semibold),
        valueMinWidth: 20,
        spacing: 4
    )
}
