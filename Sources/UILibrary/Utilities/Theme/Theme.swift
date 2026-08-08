//
//  Theme.swift
//  UILibrary
//
//  Created by Marco La Gala on 08/02/26.
//

import Foundation
import SwiftUI

/// Represents the app's appearance mode preference (Light, Dark, or System).
///
/// - Note: This type only models the color-scheme preference. Design tokens
///   (colors, typography, spacing) are intentionally NOT part of this library:
///   the app or its design-system module owns them and injects them through
///   each component's `Style` struct (Theme → StyleFactory → Component(style:)).
public enum Theme: String, CaseIterable, Identifiable, Sendable {
    case light
    case dark
    case system
    
    public var id: String { rawValue }
    
    /// Display name for the theme, localized from the library's string catalog.
    public var displayName: LocalizedStringResource {
        switch self {
        case .light: LocalizedStringResource("Light", bundle: .atURL(Bundle.module.bundleURL))
        case .dark: LocalizedStringResource("Dark", bundle: .atURL(Bundle.module.bundleURL))
        case .system: LocalizedStringResource("System", bundle: .atURL(Bundle.module.bundleURL))
        }
    }
    
    /// Icon name for SF Symbols representation.
    public var iconName: String {
        switch self {
        case .light: "sun.max.fill"
        case .dark: "moon.fill"
        case .system: "circle.lefthalf.filled"
        }
    }
    
    public var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
