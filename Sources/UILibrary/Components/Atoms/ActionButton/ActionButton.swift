import SwiftUI

/// A reusable, style-driven action button supporting primary / secondary / destructive / ghost presets.
///
/// - Responsibility: single source of truth for primary tappable actions used across the app.
/// - Style: visual appearance is injected via `ActionButtonStyle`.
///
/// ## Usage
/// ```swift
/// ActionButton("Continue", style: .primary) { submit() }
/// ActionButton("Delete", isEnabled: isReady, style: .destructive) { delete() }
/// ActionButton("Add more", style: .secondary) { add() }
/// ```
public struct ActionButton: View {
    /// Size variants for `ActionButton`.
    public enum Size: Equatable {
        case compact, regular, large
    }

    public let title: LocalizedStringResource
    public let systemName: String?
    public let isEnabled: Bool
    public let size: Size
    private let style: ActionButtonStyle
    private let action: () -> Void

    /// Creates an `ActionButton`.
    /// - Parameters:
    ///   - title: Localized title (string literal supported).
    ///   - systemName: Optional SF Symbol name shown to the leading edge of the label.
    ///   - isEnabled: Enable / disable the button (default: `true`).
    ///   - size: Visual size variant — `.regular` by default.
    ///   - style: Visual style (default: `.primary`).
    ///   - action: Tap action.
    public init(
        _ title: LocalizedStringResource,
        systemName: String? = nil,
        isEnabled: Bool = true,
        size: Size = .regular,
        style: ActionButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemName = systemName
        self.isEnabled = isEnabled
        self.size = size
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let systemName, !systemName.isEmpty {
                    Image(systemName: systemName)
                        .font(fontForSize)
                        .foregroundColor(currentForeground)
                }

                Text(title)
                    .font(fontForSize)
                    .foregroundColor(currentForeground)
                    .lineLimit(1)
                    .frame(maxWidth: style.fullWidth ? .infinity : nil, alignment: .center)
            }
            .padding(.vertical, verticalPaddingForSize)
            .padding(.horizontal, style.horizontalPadding)
            .contentShape(Rectangle())
            .frame(minWidth: style.fullWidth ? 0 : nil, minHeight: style.minTapTarget.height)
            .background(backgroundView)
            .overlay(borderOverlay)
            .cornerRadius(style.cornerRadius)
            .shadow(color: shadowColor, radius: style.shadowRadius, x: 0, y: style.shadowYOffset)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityAddTraits(.isButton)
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
