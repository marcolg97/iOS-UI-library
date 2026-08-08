//
//  ErrorStateViewStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// Style contract for `ErrorStateView`.
///
/// Describes visual tokens used by `ErrorStateView` (icon, colors, fonts, button style).
/// Immutable and brand-agnostic.
public struct ErrorStateViewStyle: Equatable, Sendable {
    /// SF Symbol name for the error icon.
    public let iconName: String
    
    /// Color for the error icon.
    public let iconColor: Color
    
    /// Color for the title text.
    public let titleColor: Color
    
    /// Font for the title text.
    public let titleFont: Font
    
    /// Color for the description text.
    public let descriptionColor: Color
    
    /// Font for the description text.
    public let descriptionFont: Font
    
    /// Title text for the retry button (localizable).
    public let retryButtonTitle: LocalizedStringResource
    
    /// Style for the retry button.
    public let retryButtonStyle: ActionButtonStyle
    
    /// Creates an `ErrorStateViewStyle`.
    /// - Parameters:
    ///   - iconName: SF Symbol name for the icon (default: "exclamationmark.triangle.fill").
    ///   - iconColor: Color for the icon (default: .red).
    ///   - titleColor: Color for the title (default: .primary).
    ///   - titleFont: Font for the title (default: .title2.bold()).
    ///   - descriptionColor: Color for the description (default: .secondary).
    ///   - descriptionFont: Font for the description (default: .body).
    ///   - retryButtonTitle: Title for the retry button (localizable; `nil` uses the library's localized "Retry").
    ///   - retryButtonStyle: Style for the retry button (default: .primary).
    public init(
        iconName: String = "exclamationmark.triangle.fill",
        iconColor: Color = .red,
        titleColor: Color = .primary,
        titleFont: Font = .title2.bold(),
        descriptionColor: Color = .secondary,
        descriptionFont: Font = .body,
        retryButtonTitle: LocalizedStringResource? = nil,
        retryButtonStyle: ActionButtonStyle = .primary
    ) {
        self.iconName = iconName
        self.iconColor = iconColor
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.descriptionColor = descriptionColor
        self.descriptionFont = descriptionFont
        self.retryButtonTitle = retryButtonTitle
            ?? LocalizedStringResource("Retry", bundle: .atURL(Bundle.module.bundleURL))
        self.retryButtonStyle = retryButtonStyle
    }
}
