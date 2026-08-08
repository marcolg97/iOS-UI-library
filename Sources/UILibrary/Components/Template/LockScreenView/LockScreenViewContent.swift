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
/// Apps should provide their own copy (and the biometric modality actually
/// available on the device — Face ID, Touch ID, Optic ID); the `.default`
/// content is intentionally neutral.
public struct LockScreenViewContent: Sendable {
    public let title: LocalizedStringResource
    public let subtitle: LocalizedStringResource
    public let unlockButtonTitle: LocalizedStringResource
    public let iconSystemName: String
    public let unlockIconSystemName: String

    public init(
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource,
        unlockButtonTitle: LocalizedStringResource,
        iconSystemName: String = "lock.shield.fill",
        unlockIconSystemName: String = "lock.open.fill"
    ) {
        self.title = title
        self.subtitle = subtitle
        self.unlockButtonTitle = unlockButtonTitle
        self.iconSystemName = iconSystemName
        self.unlockIconSystemName = unlockIconSystemName
    }
}

public extension LockScreenViewContent {
    /// Neutral, biometric-agnostic default content, localized from the
    /// library's string catalog.
    static let `default`: LockScreenViewContent = .init(
        title: LocalizedStringResource("Locked", bundle: .atURL(Bundle.module.bundleURL)),
        subtitle: LocalizedStringResource("Unlock to continue.", bundle: .atURL(Bundle.module.bundleURL)),
        unlockButtonTitle: LocalizedStringResource("Unlock", bundle: .atURL(Bundle.module.bundleURL))
    )
}
