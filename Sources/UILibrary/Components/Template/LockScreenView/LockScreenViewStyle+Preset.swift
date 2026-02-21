//
//  LockScreenViewStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Common `LockScreenViewStyle` presets.
public extension LockScreenViewStyle {
    static let `default`: LockScreenViewStyle = .init(
        backgroundColor: .clear,
        iconColor: .secondary,
        titleColor: .primary,
        subtitleColor: .secondary,
        buttonBackgroundColor: Color.primary.opacity(0.25),
        buttonForegroundColor: .primary
    )
}
