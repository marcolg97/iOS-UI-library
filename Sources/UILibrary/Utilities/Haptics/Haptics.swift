//
//  Haptics.swift
//  CleanExpenseTracker
//
//  Created by Marco La Gala on 05/02/26.
//

import Foundation
#if os(macOS)
import AppKit
#endif

/// Cross-platform haptics helper.
/// - iOS: maps to `UIImpactFeedbackGenerator` / `UINotificationFeedbackGenerator`.
/// - macOS: maps to `NSHapticFeedbackManager` where available.
/// - Fallback: no-op on unsupported platforms.
@MainActor
public enum Haptics {
    /// Cross-platform impact strength.
    public enum ImpactStyle {
        case light, medium, heavy
    }

    /// Cross-platform notification types.
    public enum NotificationType {
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
