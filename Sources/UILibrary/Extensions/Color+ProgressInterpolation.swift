//
//  Color+ProgressInterpolation.swift
//  UILibrary
//

import SwiftUI

public extension Color {
    /// Interpolates across `stops` at a fractional `progress` measured in "pages".
    ///
    /// Built for backgrounds driven by a paged `ScrollView`: `stops[0]` is the resting colour for
    /// page 0, `stops[1]` for page 1, and a progress of `1.35` blends 35% of the way from the
    /// second stop toward the third, so the background moves continuously with the drag instead of
    /// snapping when the page settles.
    ///
    /// `progress` is unclamped input; values outside `0...stops.count - 1` clamp to the nearest end
    /// colour. Mixing is perceptual, so intermediate colours do not go muddy the way naive RGB
    /// interpolation does.
    @available(iOS 18, macOS 15, *)
    static func interpolating(_ stops: [Color], progress: Double) -> Color {
        guard let first = stops.first else { return .clear }
        guard stops.count > 1 else { return first }

        let upperBound = Double(stops.count - 1)
        let clamped = min(max(progress, 0), upperBound)
        let lowerIndex = min(Int(clamped.rounded(.down)), stops.count - 2)
        let fraction = clamped - Double(lowerIndex)

        return stops[lowerIndex].mix(with: stops[lowerIndex + 1], by: fraction, in: .perceptual)
    }
}
