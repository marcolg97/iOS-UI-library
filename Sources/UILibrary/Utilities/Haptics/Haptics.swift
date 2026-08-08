//
//  Haptics.swift
//  UILibrary
//
//  Created by Marco La Gala on 05/02/26.
//

import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif


/// Cross-platform haptics helper.
/// - iOS: maps to `UIImpactFeedbackGenerator` / `UINotificationFeedbackGenerator`.
/// - macOS: maps to `NSHapticFeedbackManager` where available.
/// - Fallback: no-op on unsupported platforms.
@MainActor
public enum Haptics {
    /// Cross-platform impact strength.
    public enum ImpactStyle: Equatable, Sendable, CaseIterable {
        case light, medium, heavy, soft, rigid
    }

    /// Cross-platform notification types.
    public enum NotificationType: Equatable, Sendable, CaseIterable {
        case success, warning, error
    }

    /// Trigger an impact haptic.
    public static func impact(_ style: ImpactStyle = .medium) {
        #if os(iOS) || targetEnvironment(macCatalyst)
        let uiStyle: UIImpactFeedbackGenerator.FeedbackStyle
        switch style {
        case .light: uiStyle = .light
        case .medium: uiStyle = .medium
        case .heavy: uiStyle = .heavy
        case .soft: uiStyle = .soft
        case .rigid: uiStyle = .rigid
        }
        let generator = UIImpactFeedbackGenerator(style: uiStyle)
        generator.prepare()
        generator.impactOccurred()
        #elseif os(macOS)
        // macOS: best effort with NSHapticFeedbackManager
        let performer = NSHapticFeedbackManager.defaultPerformer
        performer.perform(.generic, performanceTime: .now)
        #else
        // no-op
        #endif
    }

    /// Trigger a notification haptic.
    public static func notify(_ type: NotificationType) {
        #if os(iOS) || targetEnvironment(macCatalyst)
        let uiType: UINotificationFeedbackGenerator.FeedbackType
        switch type {
        case .success: uiType = .success
        case .warning: uiType = .warning
        case .error: uiType = .error
        }
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(uiType)
        #elseif os(macOS)
        let performer = NSHapticFeedbackManager.defaultPerformer
        switch type {
        case .success:
            performer.perform(.levelChange, performanceTime: .now)
        case .warning, .error:
            performer.perform(.generic, performanceTime: .now)
        }
        #else
        // no-op
        #endif
    }
}
