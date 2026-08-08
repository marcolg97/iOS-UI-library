//
//  SkeletonStyle+Preset.swift
//  UILibrary
//

import SwiftUI

/// Common `SkeletonStyle` presets.
public extension SkeletonStyle {
    /// Default preset — subtle neutral shimmer.
    static let `default` = SkeletonStyle()

    /// Rounded preset — capsule-like placeholder for text lines.
    static let rounded = SkeletonStyle(cornerRadius: 999)
}
