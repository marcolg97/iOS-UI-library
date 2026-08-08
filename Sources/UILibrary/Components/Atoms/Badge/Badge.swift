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
    public let text: LocalizedStringResource
    public let style: BadgeStyle

    /// Creates a `Badge`.
    /// - Parameters:
    ///   - text: Accessible text shown inside the badge.
    ///   - style: Visual style for the badge. Defaults to `.default`.
    public init(_ text: LocalizedStringResource, style: BadgeStyle = .default) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundStyle(style.foregroundColor)
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
    }
}

#if DEBUG
#Preview() {
    Text(verbatim: "Default").font(.caption).foregroundStyle(.gray)
    VStack(spacing: 12) {
        Badge(.verbatim("New"))
        Badge(.verbatim("Default"), style: .default)
        Badge(.verbatim("Neutral"), style: .neutral)
    }
    .padding()

    Text(verbatim: "Semantic Colors").font(.caption).foregroundStyle(.gray)
    VStack(spacing: 12) {
        Badge(.verbatim("Info"), style: .accent)
        Badge(.verbatim("Success"), style: .success)
        Badge(.verbatim("Warning"), style: .warning)
        Badge(.verbatim("Error"), style: .error)
    }
    .padding()

    Text(verbatim: "Outlined").font(.caption).foregroundStyle(.gray)
    VStack(spacing: 12) {
        Badge(.verbatim("Outlined"), style: .outlined())
        Badge(.verbatim("Blue"), style: .outlined(.blue))
        Badge(.verbatim("Red"), style: .outlined(.red))
    }
    .padding()

    Text(verbatim: "Count Badges").font(.caption).foregroundStyle(.gray)
    HStack(spacing: 12) {
        Badge(.verbatim("1"), style: .accent)
        Badge(.verbatim("5"), style: .success)
        Badge(.verbatim("99+"), style: .error)
    }
    .padding()

    Text(verbatim: "3D Style").font(.caption).foregroundStyle(.gray)
    VStack(spacing: 12) {
        Badge(.verbatim("3D"), style: .threeDimensional())
        Badge(.verbatim("New"), style: .threeDimensional(.purple))
        Badge(.verbatim("Pro"), style: .threeDimensional(.green))
    }
    .padding()
}
#endif

