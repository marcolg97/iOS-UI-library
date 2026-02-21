import SwiftUI

/// Style contract for SwitchAtom
public struct SwitchAtomStyle: Equatable {
    public let trackWidth: CGFloat
    public let trackHeight: CGFloat
    public let thumbSize: CGFloat
    public let thumbOffset: CGFloat
    public let trackOnColor: Color
    public let trackOffColor: Color
    public let thumbColor: Color
    public let disabledOpacity: Double

    public init(
        trackWidth: CGFloat,
        trackHeight: CGFloat,
        thumbSize: CGFloat,
        thumbOffset: CGFloat,
        trackOnColor: Color,
        trackOffColor: Color,
        thumbColor: Color,
        disabledOpacity: Double
    ) {
        self.trackWidth = trackWidth
        self.trackHeight = trackHeight
        self.thumbSize = thumbSize
        self.thumbOffset = thumbOffset
        self.trackOnColor = trackOnColor
        self.trackOffColor = trackOffColor
        self.thumbColor = thumbColor
        self.disabledOpacity = disabledOpacity
    }
}
