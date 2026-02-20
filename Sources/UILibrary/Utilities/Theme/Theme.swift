//
//  Theme.swift
//  CoreModules
//
//  Created by Marco La Gala on 08/02/26.
//

import Foundation
import SwiftUI

/// Represents the app's theme mode preference.
///
/// Defines the visual appearance of the app (Light, Dark, or System-based).
public enum Theme: String, CaseIterable, Identifiable, Sendable {
    case light
    case dark
    case system
    
    public var id: String { rawValue }
    
    /// Display name for the theme (English fallback).
    public var displayName: LocalizedStringResource {
        switch self {
        case .light: LocalizedStringResource("Light")
        case .dark: LocalizedStringResource("Dark")
        case .system: LocalizedStringResource("System")
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
