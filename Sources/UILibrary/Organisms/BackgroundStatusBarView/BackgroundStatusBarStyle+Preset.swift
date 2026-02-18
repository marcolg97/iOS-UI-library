//
//  BackgroundStatusBarStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

import Foundation

/// Common `BackgroundStatusBarStyle` presets.
public extension BackgroundStatusBarStyle {
    /// Warning preset — suitable for offline/attention states (yellow background, 60pt height).
    static let warning: BackgroundStatusBarStyle = .init(backgroundColor: .yellow, height: 60)
}
