import SwiftUI

public extension SwitchAtomStyle {
    static let `default` = SwitchAtomStyle(
        trackWidth: 50,
        trackHeight: 30,
        thumbSize: 24,
        thumbOffset: 10,
        trackOnColor: .green,
        trackOffColor: Color.gray,
        thumbColor: .white,
        disabledOpacity: 0.5
    )

    static let compact = SwitchAtomStyle(
        trackWidth: 40,
        trackHeight: 24,
        thumbSize: 18,
        thumbOffset: 8,
        trackOnColor: .blue,
        trackOffColor: Color.gray.opacity(0.2),
        thumbColor: .white,
        disabledOpacity: 0.45
    )

    static let modern = SwitchAtomStyle(
        trackWidth: 56,
        trackHeight: 34,
        thumbSize: 28,
        thumbOffset: 12,
        trackOnColor: .accentColor,
        trackOffColor: Color.gray.opacity(0.1),
        thumbColor: .white,
        disabledOpacity: 0.5
    )
}
