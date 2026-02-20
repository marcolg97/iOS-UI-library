import SwiftUI

/// A small, style-driven status label for displaying status, count, or tag-like information.
///
/// - Responsibility: presentational UI only — displays text with visual styling. No business logic.
/// - Layer: Atom (primitive UI component)
/// - Style: visual appearance injected via `BadgeStyle`.
///
/// ## Features
/// - Style-driven (immutable `BadgeStyle`)
/// - Compact presentation with customizable padding
/// - Border support (optional)
/// - Accessibility-aware (text is used as accessibility label)
///
/// ## Usage
/// ```swift
/// // Default badge
/// Badge("New")
///
/// // Using presets
/// Badge("5", style: .accent)
/// Badge("Active", style: .success)
///
/// // Custom style
/// Badge("Pro", style: .outlined(.blue))
/// ```
public struct Badge: View {
    public let text: String
    public let style: BadgeStyle

    /// Creates a `Badge`.
    /// - Parameters:
    ///   - text: Accessible text shown inside the badge.
    ///   - style: Visual style for the badge. Defaults to `.default`.
    public init(_ text: String, style: BadgeStyle = .default) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(style.foregroundColor)
            .padding(.init(top: style.verticalPadding, leading: style.horizontalPadding, bottom: style.verticalPadding, trailing: style.horizontalPadding))
            .background(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .fill(style.backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .stroke(style.borderColor ?? Color.clear, lineWidth: style.borderWidth)
            )
            .shadow(
                color: style.shadowColor ?? .clear,
                radius: style.shadowRadius,
                x: style.shadowOffset.width,
                y: style.shadowOffset.height
            )
            .fixedSize()
            .accessibilityLabel(text)
    }
}

#Preview("Default") {
    VStack(spacing: 12) {
        Badge("New")
        Badge("Default", style: .default)
        Badge("Neutral", style: .neutral)
    }
    .padding()
}

#Preview("Semantic Colors") {
    VStack(spacing: 12) {
        Badge("Info", style: .accent)
        Badge("Success", style: .success)
        Badge("Warning", style: .warning)
        Badge("Error", style: .error)
    }
    .padding()
}

#Preview("Outlined") {
    VStack(spacing: 12) {
        Badge("Outlined", style: .outlined())
        Badge("Blue", style: .outlined(.blue))
        Badge("Red", style: .outlined(.red))
    }
    .padding()
}

#Preview("Count Badges") {
    HStack(spacing: 12) {
        Badge("1", style: .accent)
        Badge("5", style: .success)
        Badge("99+", style: .error)
    }
    .padding()
}

#Preview("3D Style") {
    VStack(spacing: 12) {
        Badge("3D", style: .threeDimensional())
        Badge("New", style: .threeDimensional(.purple))
        Badge("Pro", style: .threeDimensional(.green))
    }
    .padding()
}

