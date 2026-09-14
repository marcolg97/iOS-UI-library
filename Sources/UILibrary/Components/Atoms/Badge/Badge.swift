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
///
/// // Minimal dot variant (no visible text) — accessibility label is required
/// Badge.dot(accessibilityLabel: "Table incomplete", style: .dot(.orange))
/// ```
public struct Badge: View {
    public let text: LocalizedStringResource
    public let style: BadgeStyle

    /// Creates a `Badge`.
    /// - Parameters:
    ///   - text: Accessible text shown inside the badge. When `style.dotDiameter` is set the text
    ///     is not drawn (the badge renders as a plain dot) but is still used as the VoiceOver label —
    ///     prefer `Badge.dot(accessibilityLabel:style:)` for that case.
    ///   - style: Visual style for the badge. Defaults to `.default`.
    public init(_ text: LocalizedStringResource, style: BadgeStyle = .default) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        if let dotDiameter = style.dotDiameter {
            Circle()
                .fill(style.backgroundColor)
                .frame(width: dotDiameter, height: dotDiameter)
                .overlay(
                    Circle()
                        .stroke(style.borderColor ?? Color.clear, lineWidth: style.borderWidth)
                )
                .shadow(
                    color: style.shadowColor ?? .clear,
                    radius: style.shadowRadius,
                    x: style.shadowOffset.width,
                    y: style.shadowOffset.height
                )
                .accessibilityLabel(Text(text))
        } else {
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
}

public extension Badge {
    /// Creates a minimal circular dot-style `Badge` — no visible text, just a filled circle.
    ///
    /// Use for lightweight status indicators (e.g. a "has updates" dot on an event card, or a
    /// table-completion indicator) where a full text/count badge would be visually heavy.
    ///
    /// - Parameter accessibilityLabel: Required VoiceOver label — a dot has no visible text, so it
    ///   would otherwise be announced as unlabeled.
    /// - Parameter style: Must have `dotDiameter` set; defaults to `.dot()`. Pass a style built
    ///   from `BadgeStyle.dot(_:diameter:)` to customize color/size.
    static func dot(accessibilityLabel: LocalizedStringResource, style: BadgeStyle = .dot()) -> Badge {
        Badge(accessibilityLabel, style: style)
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

    Text(verbatim: "Dot").font(.caption).foregroundStyle(.gray)
    HStack(spacing: 12) {
        Badge.dot(accessibilityLabel: .verbatim("Default status"))
        Badge.dot(accessibilityLabel: .verbatim("Warning status"), style: .dot(.orange))
        Badge.dot(accessibilityLabel: .verbatim("Success status"), style: .dot(.green, diameter: 14))
    }
    .padding()
}
#endif

