//
//  LockScreenViewContent.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import Foundation

/// Content contract for `LockScreenView`.
///
/// Defines user-facing strings and SF Symbols used by the lock screen.
public struct LockScreenViewContent: Equatable, Sendable {
    public let title: String
    public let subtitle: String
    public let unlockButtonTitle: String
    public let iconSystemName: String
    public let unlockIconSystemName: String

    public init(
        title: String,
        subtitle: String,
        unlockButtonTitle: String,
        iconSystemName: String = "lock.shield.fill",
        unlockIconSystemName: String = "faceid"
    ) {
        self.title = title
        self.subtitle = subtitle
        self.unlockButtonTitle = unlockButtonTitle
        self.iconSystemName = iconSystemName
        self.unlockIconSystemName = unlockIconSystemName
    }
}

public extension LockScreenViewContent {
    static let `default`: LockScreenViewContent = .init(
        title: "Secure Access",
        subtitle: "Use Face ID to unlock and continue.",
        unlockButtonTitle: "Unlock with Face ID"
    )
}
