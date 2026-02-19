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
/// - Icon-only convenience initializer
/// - Accessibility-aware (configurable `accessibilityTrait`)
///
/// ## Usage
/// ```swift
/// // Simple text button
/// ActionButton("Continue", style: .primary) { submit() }
///
/// // Icon-only
/// ActionButton(systemName: "trash", style: .destructive) { delete() }
///
/// // Custom label (content initializer)
/// ActionButton(isEnabled: true, style: .primary) {
///     HStack { Image(systemName: "plus"); Text("Add") }
/// } action: { add() }
/// ```
public struct ActionButton<Label: View>: View {
    /// Size variants for `ActionButton`.
    public enum Size: Equatable {
        case compact, regular, large
    }

    private let label: Label
    public let isEnabled: Bool
    public let size: Size

    // Accessibility trait (default: button)
    private let accessibilityTrait: AccessibilityTraits

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
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Group {
                if let w = fixedWidth {
                    label
                        .font(fontForSize)
                        .foregroundColor(currentForeground)
                        .padding(.vertical, verticalPaddingForSize)
                        .padding(.horizontal, style.horizontalPadding)
                        .contentShape(Rectangle())
                        .frame(minWidth: w, maxWidth: w, minHeight: style.minTapTarget.height)
                } else {
                    label
                        .font(fontForSize)
                        .foregroundColor(currentForeground)
                        .padding(.vertical, verticalPaddingForSize)
                        .padding(.horizontal, style.horizontalPadding)
                        .contentShape(Rectangle())
                        .frame(maxWidth: style.defaultMaxWidth, minHeight: style.minTapTarget.height)
                }
            }
            .background(backgroundView)
            .overlay(borderOverlay)
            .cornerRadius(style.cornerRadius)
            .shadow(color: shadowColor, radius: style.shadowRadius, x: 0, y: style.shadowYOffset)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityAddTraits(accessibilityTrait)
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
    public init(
        systemName: String,
        isEnabled: Bool = true,
        size: Size = .regular,
        style: ActionButtonStyle = .primary,
        accessibilityTrait: AccessibilityTraits = .isButton,
        action: @escaping () -> Void
    ) where Label == Image {
        self.init(isEnabled: isEnabled, size: size, style: style, accessibilityTrait: accessibilityTrait, action: action) {
            Image(systemName: systemName)
        }
    }
}

#Preview("Styles · Sizes") {
    ScrollView {
        VStack(spacing: 20) {
            Group {
                Text("Primary").font(.caption).foregroundColor(.gray)
                VStack(spacing: 8) {
                    ActionButton("Compact", size: .compact, style: .primary) {}
                    ActionButton("Compact (disabled)", isEnabled: false, size: .compact, style: .primary) {}
                    ActionButton("Regular", size: .regular, style: .primary) {}
                    ActionButton("Regular (disabled)", isEnabled: false, size: .regular, style: .primary) {}
                    ActionButton("Large", size: .large, style: .primary) {}
                    ActionButton("Large (disabled)", isEnabled: false, size: .large, style: .primary) {}
                }
                .frame(maxWidth: 320)

                Text("Primary (cyan)").font(.caption).foregroundColor(.gray)
                VStack(spacing: 8) {
                    ActionButton("CONTINUA", style: .primaryCyan) {}
                    ActionButton("COMPLETA I DATI", isEnabled: false, style: .primaryCyan) {}
                }
                .frame(maxWidth: 320)
            }

            Group {
                Text("Secondary").font(.caption).foregroundColor(.gray)
                VStack(spacing: 8) {
                    ActionButton("Compact", size: .compact, style: .secondary) {}
                    ActionButton("Compact (disabled)", isEnabled: false, size: .compact, style: .secondary) {}
                    ActionButton("Regular", size: .regular, style: .secondary) {}
                    ActionButton("Regular (disabled)", isEnabled: false, size: .regular, style: .secondary) {}
                    ActionButton("Large", size: .large, style: .secondary) {}
                    ActionButton("Large (disabled)", isEnabled: false, size: .large, style: .secondary) {}
                }
                .frame(maxWidth: 320)
            }

            Group {
                Text("Destructive").font(.caption).foregroundColor(.gray)
                VStack(spacing: 8) {
                    ActionButton("Compact", size: .compact, style: .destructive) {}
                    ActionButton("Compact (disabled)", isEnabled: false, size: .compact, style: .destructive) {}
                    ActionButton("Regular", size: .regular, style: .destructive) {}
                    ActionButton("Regular (disabled)", isEnabled: false, size: .regular, style: .destructive) {}
                    ActionButton("Large", size: .large, style: .destructive) {}
                    ActionButton("Large (disabled)", isEnabled: false, size: .large, style: .destructive) {}
                }
                .frame(maxWidth: 320)
            }

            Group {
                Text("Ghost (intrinsic width)").font(.caption).foregroundColor(.gray)
                VStack(spacing: 12) {
                    ActionButton("Compact", size: .compact, style: .ghost) {}
                    ActionButton("Compact (disabled)", isEnabled: false, size: .compact, style: .ghost) {}
                    ActionButton("Regular", size: .regular, style: .ghost) {}
                    ActionButton("Regular (disabled)", isEnabled: false, size: .regular, style: .ghost) {}
                    ActionButton("Large", size: .large, style: .ghost) {}
                    ActionButton("Large (disabled)", isEnabled: false, size: .large, style: .ghost) {}
                }
            }

            Group {
                Text("Mixed row").font(.caption).foregroundColor(.gray)
                HStack(spacing: 12) {
                    ActionButton("Primary", size: .regular, style: .primary) {}
                    ActionButton("Secondary", size: .regular, style: .secondary) {}
                }
                .frame(maxWidth: 320)
            }

            Group {
                Text("Custom / icon-only examples").font(.caption).foregroundColor(.gray)
                VStack(spacing: 12) {
                    ActionButton(systemName: "heart.fill", style: .ghost) {}
                    ActionButton(systemName: "trash", style: .destructive) {}
                    ActionButton(systemName: "star", style: .iconCircle) {}
                    ActionButton(isEnabled: true, style: .primary, action: { }) {
                        HStack { Image(systemName: "plus"); Text("Add item") }
                    }
                }
                .frame(maxWidth: 320)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("Primary (cyan) — disabled check") {
    VStack(spacing: 8) {
        ActionButton("CONTINUA", style: .primaryCyan) {}
        ActionButton("COMPLETA I DATI", isEnabled: false, style: .primaryCyan) {}
    }
    .padding()
    .cornerRadius(8)
}
