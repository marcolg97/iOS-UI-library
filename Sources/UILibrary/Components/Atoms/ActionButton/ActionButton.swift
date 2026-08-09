import SwiftUI

/// A reusable, style-driven action button supporting primary / secondary / destructive / ghost presets.
///
/// - Responsibility: single source of truth for tappable actions used across the app.
/// - Style: visual appearance is injected via `ActionButtonStyle`.
///
/// ## Features
/// - Style-driven (immutable `ActionButtonStyle`)
/// - Size variants (`.compact`, `.regular`, `.large`)
/// - Content-based initializer for custom labels
/// - Icon-only convenience initializer (requires an accessibility label)
/// - Accessibility-aware (configurable `accessibilityTrait`)
///
/// ## Usage
/// ```swift
/// // Simple text button
/// ActionButton("Continue", style: .primary) { submit() }
///
/// // Icon-only — the accessibility label is required
/// ActionButton(systemName: "trash", accessibilityLabel: "Delete", style: .destructive) { delete() }
///
/// // Custom label (content initializer)
/// ActionButton(isEnabled: true, style: .primary) {
///     HStack { Image(systemName: "plus"); Text("Add") }
/// } action: { add() }
/// ```
public struct ActionButton<Label: View>: View {
    /// Size variants for `ActionButton`.
    public enum Size: Equatable, Sendable {
        case compact, regular, large
    }

    private let label: Label
    public let isEnabled: Bool
    public let size: Size

    // Accessibility trait (default: button)
    private let accessibilityTrait: AccessibilityTraits

    // Optional explicit accessibility label (used by the icon-only initializer)
    private let accessibilityLabelText: Text?

    private let style: ActionButtonStyle
    private let action: () -> Void

    /// Primary generic initializer — action param comes before the label so call-sites
    /// that use two trailing closures keep the same ordering as before.
    public init(
        isEnabled: Bool = true,
        size: Size = .regular,
        style: ActionButtonStyle = .primary,
        accessibilityTrait: AccessibilityTraits = .isButton,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.label = label()
        self.isEnabled = isEnabled
        self.size = size
        self.accessibilityTrait = accessibilityTrait
        self.accessibilityLabelText = nil
        self.style = style
        self.action = action
    }

    fileprivate init(
        isEnabled: Bool,
        size: Size,
        style: ActionButtonStyle,
        accessibilityTrait: AccessibilityTraits,
        accessibilityLabelText: Text?,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.label = label()
        self.isEnabled = isEnabled
        self.size = size
        self.accessibilityTrait = accessibilityTrait
        self.accessibilityLabelText = accessibilityLabelText
        self.style = style
        self.action = action
    }

    public var body: some View {
        if let accessibilityLabelText {
            core.accessibilityLabel(accessibilityLabelText)
        } else {
            core
        }
    }

    private var core: some View {
        Button(action: action) {
            Group {
                if let w = fixedWidth {
                    styledLabel
                        .frame(minWidth: w, maxWidth: w, minHeight: style.minTapTarget.height)
                } else {
                    styledLabel
                        .frame(maxWidth: style.defaultMaxWidth, minHeight: style.minTapTarget.height)
                }
            }
            .background(backgroundView)
            .overlay(borderOverlay)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            .shadow(color: shadowColor, radius: style.shadowRadius, x: 0, y: style.shadowYOffset)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityAddTraits(accessibilityTrait)
    }

    private var styledLabel: some View {
        label
            .font(fontForSize)
            .foregroundStyle(currentForeground)
            .padding(.vertical, verticalPaddingForSize)
            .padding(.horizontal, style.horizontalPadding)
            .contentShape(Rectangle())
    }

    private var currentForeground: Color { isEnabled ? style.foregroundColor : style.disabledForegroundColor }
    private var currentBackground: Color { isEnabled ? style.backgroundColor : style.disabledBackgroundColor }
    private var shadowColor: Color { isEnabled ? style.shadowColor : .clear }

    private var fontForSize: Font {
        switch size {
        case .compact:
            return .callout.weight(.semibold)
        case .regular:
            return style.font
        case .large:
            return .title3.weight(.semibold)
        }
    }

    private var verticalPaddingForSize: CGFloat {
        switch size {
        case .compact: return max(6, style.verticalPadding * 0.6)
        case .regular: return style.verticalPadding
        case .large: return style.verticalPadding * 1.4
        }
    }

    /// Fixed width to apply when `defaultMaxWidth` is a finite value.
    private var fixedWidth: CGFloat? {
        guard let w = style.defaultMaxWidth, w.isFinite else { return nil }
        return w
    }

    @ViewBuilder
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: style.cornerRadius).fill(currentBackground)
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if let border = style.borderColor {
            let strokeColor = isEnabled ? border : (style.disabledBorderColor ?? border)
            RoundedRectangle(cornerRadius: style.cornerRadius)
                .stroke(strokeColor, lineWidth: 1)
        } else {
            EmptyView()
        }
    }
}

extension ActionButton {
    /// Convenience initializer for simple text labels (`Label == Text`).
    public init(
        _ title: LocalizedStringResource,
        isEnabled: Bool = true,
        size: Size = .regular,
        style: ActionButtonStyle = .primary,
        accessibilityTrait: AccessibilityTraits = .isButton,
        action: @escaping () -> Void
    ) where Label == Text {
        self.init(isEnabled: isEnabled, size: size, style: style, accessibilityTrait: accessibilityTrait, action: action) {
            Text(title)
        }
    }

    /// Convenience initializer for icon-only buttons (`Label == Image`).
    ///
    /// - Parameter accessibilityLabel: Required VoiceOver label for the button —
    ///   an icon-only button is otherwise announced as an unlabeled button.
    public init(
        systemName: String,
        accessibilityLabel: LocalizedStringResource,
        isEnabled: Bool = true,
        size: Size = .regular,
        style: ActionButtonStyle = .primary,
        accessibilityTrait: AccessibilityTraits = .isButton,
        action: @escaping () -> Void
    ) where Label == Image {
        self.init(
            isEnabled: isEnabled,
            size: size,
            style: style,
            accessibilityTrait: accessibilityTrait,
            accessibilityLabelText: Text(accessibilityLabel),
            action: action
        ) {
            Image(systemName: systemName)
        }
    }
}

#if DEBUG
#Preview("Styles · Sizes") {
    PreviewContainer {
        Group {
            Text(verbatim: "Primary").font(.caption).foregroundStyle(.gray)
            VStack(spacing: 8) {
                ActionButton(.verbatim("Compact"), size: .compact, style: .primary) {}
                ActionButton(.verbatim("Compact (disabled)"), isEnabled: false, size: .compact, style: .primary) {}
                ActionButton(.verbatim("Regular"), size: .regular, style: .primary) {}
                ActionButton(.verbatim("Regular (disabled)"), isEnabled: false, size: .regular, style: .primary) {}
                ActionButton(.verbatim("Large"), size: .large, style: .primary) {}
                ActionButton(.verbatim("Large (disabled)"), isEnabled: false, size: .large, style: .primary) {}
            }
            .frame(maxWidth: 320)
            
            Text(verbatim: "Tonal").font(.caption).foregroundStyle(.gray)
            VStack(spacing: 8) {
                ActionButton(.verbatim("Continue"), style: .tonal) {}
                ActionButton(.verbatim("Complete your data"), isEnabled: false, style: .tonal) {}
            }
            .frame(maxWidth: 320)
        }
        
        Group {
            Text(verbatim: "Secondary").font(.caption).foregroundStyle(.gray)
            VStack(spacing: 8) {
                ActionButton(.verbatim("Compact"), size: .compact, style: .secondary) {}
                ActionButton(.verbatim("Compact (disabled)"), isEnabled: false, size: .compact, style: .secondary) {}
                ActionButton(.verbatim("Regular"), size: .regular, style: .secondary) {}
                ActionButton(.verbatim("Regular (disabled)"), isEnabled: false, size: .regular, style: .secondary) {}
                ActionButton(.verbatim("Large"), size: .large, style: .secondary) {}
                ActionButton(.verbatim("Large (disabled)"), isEnabled: false, size: .large, style: .secondary) {}
            }
            .frame(maxWidth: 320)
        }
        
        Group {
            Text(verbatim: "Destructive").font(.caption).foregroundStyle(.gray)
            VStack(spacing: 8) {
                ActionButton(.verbatim("Compact"), size: .compact, style: .destructive) {}
                ActionButton(.verbatim("Compact (disabled)"), isEnabled: false, size: .compact, style: .destructive) {}
                ActionButton(.verbatim("Regular"), size: .regular, style: .destructive) {}
                ActionButton(.verbatim("Regular (disabled)"), isEnabled: false, size: .regular, style: .destructive) {}
                ActionButton(.verbatim("Large"), size: .large, style: .destructive) {}
                ActionButton(.verbatim("Large (disabled)"), isEnabled: false, size: .large, style: .destructive) {}
            }
            .frame(maxWidth: 320)
        }
        
        Group {
            Text(verbatim: "Ghost (intrinsic width)").font(.caption).foregroundStyle(.gray)
            VStack(spacing: 12) {
                ActionButton(.verbatim("Compact"), size: .compact, style: .ghost) {}
                ActionButton(.verbatim("Compact (disabled)"), isEnabled: false, size: .compact, style: .ghost) {}
                ActionButton(.verbatim("Regular"), size: .regular, style: .ghost) {}
                ActionButton(.verbatim("Regular (disabled)"), isEnabled: false, size: .regular, style: .ghost) {}
                ActionButton(.verbatim("Large"), size: .large, style: .ghost) {}
                ActionButton(.verbatim("Large (disabled)"), isEnabled: false, size: .large, style: .ghost) {}
            }
        }
        
        Group {
            Text(verbatim: "Mixed row").font(.caption).foregroundStyle(.gray)
            HStack(spacing: 12) {
                ActionButton(.verbatim("Primary"), size: .regular, style: .primary) {}
                ActionButton(.verbatim("Secondary"), size: .regular, style: .secondary) {}
            }
            .frame(maxWidth: 320)
        }
        
        Group {
            Text(verbatim: "Custom / icon-only examples").font(.caption).foregroundStyle(.gray)
            VStack(spacing: 12) {
                ActionButton(systemName: "heart.fill", accessibilityLabel: .verbatim("Favorite"), style: .ghost) {}
                ActionButton(systemName: "trash", accessibilityLabel: .verbatim("Delete"), style: .destructive) {}
                ActionButton(systemName: "star", accessibilityLabel: .verbatim("Star"), style: .iconCircle) {}
                ActionButton(isEnabled: true, style: .primary, action: { }) {
                    HStack {
                        Image(systemName: "plus")
                        Text(verbatim: "Add item")
                    }
                }
            }
            .frame(maxWidth: 320)
        }
    }
}

#Preview("Tonal — disabled check") {
    VStack(spacing: 8) {
        ActionButton(.verbatim("Continue"), style: .tonal) {}
        ActionButton(.verbatim("Complete your data"), isEnabled: false, style: .tonal) {}
    }
    .padding()
}
#endif
