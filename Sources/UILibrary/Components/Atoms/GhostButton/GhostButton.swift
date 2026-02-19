//
//  GhostButton.swift
//  CleanExpenseTracker
//
//  Created by Marco La Gala on 04/02/26.
//

import SwiftUI

/// A lightweight button styled as a link or action with optional icon.
///
/// GhostButton provides a minimal, non-intrusive button style suitable for inline actions,
/// navigation links, or secondary actions. When no icon is provided, the text appears underlined
/// to indicate interactivity.
///
/// ## Accessibility
/// - Supports configurable accessibility traits (`.isLink` or `.isButton`)
/// - Default trait is `.isButton` for standard actions
/// - Use `.isLink` trait when the button navigates to external content or URLs
///
/// ## Usage
/// ```swift
/// // Button with icon (no underline)
/// GhostButton(text: "Email us", systemName: "arrow.up.right") {
///     openEmail()
/// }
///
/// // Link-style without icon (underlined)
/// GhostButton(text: "Learn more", accessibilityTrait: .isLink) {
///     openURL(learnMoreURL)
/// }
///
/// // Button without icon
/// GhostButton(text: "Send Email") {
///     composeMail()
/// }
/// ```
public struct GhostButton: View {
    /// The localized text to display
    let text: LocalizedStringResource

    /// Optional SF Symbol name for the icon (if nil, text appears underlined)
    let systemName: String?

    /// The accessibility trait to apply to the button
    let accessibilityTrait: AccessibilityTraits

    /// Visual style for the button
    private let style: GhostButtonStyle

    /// The action to perform when the button is tapped
    let action: () -> Void

    /// Creates a ghost button with optional icon and injectable style.
    /// - Parameters:
    ///   - text: Localized text for the button
    ///   - systemName: Optional SF Symbol name. If nil, text may be underlined depending on `style`.
    ///   - accessibilityTrait: The accessibility trait (default: `.isButton`). Use `.isLink` for navigation.
    ///   - style: `GhostButtonStyle` describing colors and typography. Default: `.neutral`.
    ///   - action: Action to perform on tap
    public init(
        text: LocalizedStringResource,
        systemName: String? = nil,
        accessibilityTrait: AccessibilityTraits = .isButton,
        style: GhostButtonStyle = .neutral,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.systemName = systemName
        self.accessibilityTrait = accessibilityTrait
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            if let systemName, !systemName.isEmpty {
                LabelImage(style: LabelImageStyle(iconPosition: .trailing, font: style.font, textColor: style.textColor, iconColor: style.iconColor)) {
                    Text(text)
                        .font(style.font)
                        .foregroundColor(style.textColor)
                } icon: {
                    Image(systemName: systemName)
                        .font(style.font)
                        .foregroundColor(style.iconColor)
                }
            } else {
                Text(text)
                    .font(style.font)
                    .underline(style.underline)
                    .foregroundColor(style.textColor)
            }
        }
        .buttonStyle(.plain)
        .frame(minWidth: style.minTapTarget.width, minHeight: style.minTapTarget.height)
        .accessibilityAddTraits(accessibilityTrait)
        .accessibilityHint(accessibilityTrait == .isLink ? "Double tap to open the link" : "Double tap to activate")
    }
}

#Preview("Default") {
    GhostButton(text: "Email us", systemName: "arrow.up.right") {
        print("Email tapped")
    }
    
    GhostButton(text: "Send Email") {
        print("Send tapped")
    }
    
    GhostButton(text: "Learn more...", accessibilityTrait: .isLink) {
        print("Learn more tapped")
    }
    
    GhostButton(text: "Email us", systemName: "arrow.up.right") {
        print("Email tapped")
    }
    .environment(\.layoutDirection, .rightToLeft)
}

