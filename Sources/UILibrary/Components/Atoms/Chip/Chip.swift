//
//  Chip.swift
//  UILibrary
//

import SwiftUI

/// Chip Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected chip/tag with optional
/// selection state, tap action, and removal affordance.
///
/// ## Usage
/// ```swift
/// // Static tag
/// Chip(.verbatim("Swift"))
///
/// // Selectable filter chip
/// Chip("Vegan", icon: "leaf", isSelected: isVegan) { isVegan.toggle() }
///
/// // Removable token
/// Chip("Filter", onRemove: { removeFilter() })
/// ```
public struct Chip: View {
    private let text: LocalizedStringResource
    private let icon: String?
    private let isSelected: Bool
    private let onTap: (() -> Void)?
    private let onRemove: (() -> Void)?
    private let style: ChipStyle

    /// Creates a `Chip`.
    /// - Parameters:
    ///   - text: Text displayed inside the chip.
    ///   - icon: Optional leading SF Symbol name.
    ///   - isSelected: Whether the chip renders in its selected state.
    ///   - style: Visual tokens (default: `.default`).
    ///   - onTap: Optional tap action; when set the chip is a button.
    ///   - onRemove: Optional removal action; when set a remove button is shown.
    public init(
        _ text: LocalizedStringResource,
        icon: String? = nil,
        isSelected: Bool = false,
        style: ChipStyle = .default,
        onTap: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil
    ) {
        self.text = text
        self.icon = icon
        self.isSelected = isSelected
        self.style = style
        self.onTap = onTap
        self.onRemove = onRemove
    }

    public var body: some View {
        if let onTap {
            Button(action: onTap) {
                label
            }
            .buttonStyle(.plain)
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
        } else {
            label
        }
    }

    private var label: some View {
        HStack(spacing: style.spacing) {
            if let icon {
                Image(systemName: icon)
                    .font(style.font)
                    .accessibilityHidden(true)
            }

            Text(text)
                .font(style.font)
                .lineLimit(1)

            if let onRemove {
                Button(action: onRemove) {
                    Image(systemName: style.removeIconSystemName)
                        .font(style.font)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text("Remove", bundle: .module))
            }
        }
        .foregroundStyle(isSelected ? style.selectedTextColor : style.textColor)
        .padding(.vertical, style.verticalPadding)
        .padding(.horizontal, style.horizontalPadding)
        .background(
            Capsule()
                .fill(isSelected ? style.selectedBackgroundColor : style.backgroundColor)
        )
        .overlay(
            Capsule()
                .stroke(
                    isSelected ? style.selectedBorderColor : style.borderColor,
                    lineWidth: style.borderWidth
                )
        )
        .frame(minHeight: style.minTapTarget)
        .contentShape(Capsule())
    }
}

#if DEBUG
#Preview("Chips") {
    @Previewable @State var isSelected = true

    VStack(spacing: 16) {
        HStack {
            Chip(.verbatim("Static"))
            Chip(.verbatim("With icon"), icon: "tag")
            Chip(.verbatim("Removable"), onRemove: {})
        }

        HStack {
            Chip(.verbatim("Selectable"), isSelected: isSelected) {
                isSelected.toggle()
            }
            Chip(.verbatim("Unselected"), isSelected: false) {}
        }
    }
    .padding()
}
#endif
