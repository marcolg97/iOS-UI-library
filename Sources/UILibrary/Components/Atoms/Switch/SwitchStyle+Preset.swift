import SwiftUI

public extension SwitchAtomStyle {
    static var previewDefault: SwitchAtomStyle {
        .init(
            trackWidth: 50,
            trackHeight: 30,
            thumbSize: 24,
            thumbOffset: 10,
            trackOnColor: .green,
            trackOffColor: Color.gray,
            thumbColor: .white,
            disabledOpacity: 0.5
        )
    }

    static var compact: SwitchAtomStyle {
        .init(
            trackWidth: 40,
            trackHeight: 24,
            thumbSize: 18,
            thumbOffset: 8,
            trackOnColor: Color(.systemBlue),
            trackOffColor: Color.gray.opacity(0.2),
            thumbColor: .white,
            disabledOpacity: 0.45
        )
    }

    static var modern: SwitchAtomStyle {
        .init(
            trackWidth: 56,
            trackHeight: 34,
            thumbSize: 28,
            thumbOffset: 12,
            trackOnColor: .cyan,
            trackOffColor: Color.gray.opacity(0.1),
            thumbColor: .white,
            disabledOpacity: 0.5
        )
    }
}
