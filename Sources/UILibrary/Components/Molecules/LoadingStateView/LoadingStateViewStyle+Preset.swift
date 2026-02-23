//
//  LoadingStateViewStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// Common, brand-agnostic `LoadingStateViewStyle` presets for quick usage.
public extension LoadingStateViewStyle {
    /// Creates a standard loading state style with spinner.
    /// - Returns: A `LoadingStateViewStyle` configured for default loading states.
    static func `default`() -> LoadingStateViewStyle {
        LoadingStateViewStyle(
            progressStyle: .spinner,
            progressColor: .accentColor,
            progressScale: 1.0,
            controlSize: .regular,
            messageColor: .secondary,
            messageFont: .body,
            spacing: 16,
            padding: 20,
            linearProgressWidth: 200
        )
    }
    
    /// Creates a minimal loading state style without message (just spinner).
    /// - Returns: A `LoadingStateViewStyle` configured for minimal loading states.
    static func minimal() -> LoadingStateViewStyle {
        LoadingStateViewStyle(
            progressStyle: .spinner,
            progressColor: .accentColor,
            progressScale: 1.0,
            controlSize: .regular,
            messageColor: .secondary,
            messageFont: .body,
            spacing: 12,
            padding: 16,
            linearProgressWidth: 200
        )
    }
    
    /// Creates a large loading state style with bigger spinner.
    /// - Returns: A `LoadingStateViewStyle` configured for large loading states.
    static func large() -> LoadingStateViewStyle {
        LoadingStateViewStyle(
            progressStyle: .spinner,
            progressColor: .accentColor,
            progressScale: 1.5,
            controlSize: .large,
            messageColor: .secondary,
            messageFont: .title3,
            spacing: 20,
            padding: 30,
            linearProgressWidth: 250
        )
    }
    
    /// Creates a small loading state style with smaller spinner.
    /// - Returns: A `LoadingStateViewStyle` configured for small loading states.
    static func small() -> LoadingStateViewStyle {
        LoadingStateViewStyle(
            progressStyle: .spinner,
            progressColor: .accentColor,
            progressScale: 0.8,
            controlSize: .small,
            messageColor: .secondary,
            messageFont: .callout,
            spacing: 12,
            padding: 16,
            linearProgressWidth: 150
        )
    }
    
    /// Creates a linear loading state style with progress bar.
    /// - Returns: A `LoadingStateViewStyle` configured for linear loading states.
    static func linear() -> LoadingStateViewStyle {
        LoadingStateViewStyle(
            progressStyle: .linear,
            progressColor: .accentColor,
            progressScale: 1.0,
            controlSize: .regular,
            messageColor: .secondary,
            messageFont: .body,
            spacing: 16,
            padding: 20,
            linearProgressWidth: 200
        )
    }
    
    /// Creates a custom loading state style with specified parameters.
    /// - Parameters:
    ///   - progressStyle: Style of progress indicator.
    ///   - progressColor: Color for the progress indicator.
    ///   - messageColor: Color for the message text.
    ///   - progressSize: Size variant (small, regular, large).
    /// - Returns: A custom `LoadingStateViewStyle`.
    static func custom(
        progressStyle: LoadingProgressStyle = .spinner,
        progressColor: Color,
        messageColor: Color,
        progressSize: ControlSize = .regular
    ) -> LoadingStateViewStyle {
        let scale: CGFloat
        let spacing: CGFloat
        let padding: CGFloat
        let font: Font
        
        switch progressSize {
        case .mini:
            scale = 0.6
            spacing = 8
            padding = 12
            font = .caption
        case .small:
            scale = 0.8
            spacing = 12
            padding = 16
            font = .callout
        case .regular:
            scale = 1.0
            spacing = 16
            padding = 20
            font = .body
        case .large:
            scale = 1.5
            spacing = 20
            padding = 30
            font = .title3
        case .extraLarge:
            scale = 2.0
            spacing = 24
            padding = 40
            font = .title2
        @unknown default:
            scale = 1.0
            spacing = 16
            padding = 20
            font = .body
        }
        
        return LoadingStateViewStyle(
            progressStyle: progressStyle,
            progressColor: progressColor,
            progressScale: scale,
            controlSize: progressSize,
            messageColor: messageColor,
            messageFont: font,
            spacing: spacing,
            padding: padding,
            linearProgressWidth: 200
        )
    }
}
