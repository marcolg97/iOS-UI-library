//
//  SkeletonStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `SkeletonView`.
public struct SkeletonStyle: Equatable, Sendable {
    /// Base placeholder color.
    public let baseColor: Color
    /// Moving highlight color of the shimmer band.
    public let highlightColor: Color
    /// Corner radius of the placeholder shape.
    public let cornerRadius: CGFloat
    /// Duration of one shimmer sweep, in seconds.
    public let shimmerDuration: Double

    public init(
        baseColor: Color = Color.primary.opacity(0.08),
        highlightColor: Color = Color.primary.opacity(0.10),
        cornerRadius: CGFloat = 8,
        shimmerDuration: Double = 1.4
    ) {
        self.baseColor = baseColor
        self.highlightColor = highlightColor
        self.cornerRadius = cornerRadius
        self.shimmerDuration = shimmerDuration
    }
}
