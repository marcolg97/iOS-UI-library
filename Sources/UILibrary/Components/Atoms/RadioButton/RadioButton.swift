import SwiftUI

/// RadioButton Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected single-choice selector.
/// Pure radio button control without labels, hints, or error states. Compose with FormLabel, FormHint, and FormError.
///
/// Radio semantics are select-only: tapping an unselected radio selects it;
/// tapping an already-selected radio does nothing. Deselection is owned by
/// the enclosing group, which selects a different option.
public struct RadioButtonAtom: View {
    // MARK: - Public API
    @Binding public var isSelected: Bool
    public let isDisabled: Bool
    public let style: RadioButtonStyle

    @ScaledMetric(relativeTo: .body) private var scale: CGFloat = 1

    // MARK: - Init
    public init(
        isSelected: Binding<Bool>,
        isDisabled: Bool = false,
        style: RadioButtonStyle = .default
    ) {
        self._isSelected = isSelected
        self.isDisabled = isDisabled
        self.style = style
    }

    // MARK: - Body
    public var body: some View {
        Button(action: select) {
            ZStack {
                Circle()
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
                    .frame(width: style.outerSize * scale, height: style.outerSize * scale)
                    .background(
                        Circle()
                            .fill(style.backgroundColor)
                            .frame(width: style.outerSize * scale, height: style.outerSize * scale)
                    )

                if isSelected {
                    Circle()
                        .fill(style.fillColor)
                        .frame(width: style.innerSize * scale, height: style.innerSize * scale)
                }
            }
            .frame(
                minWidth: max(style.outerSize * scale, style.minTapTarget),
                minHeight: max(style.outerSize * scale, style.minTapTarget)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityLabel(Text("Radio button", bundle: .module))
        .accessibilityValue(isSelected ? Text("Selected", bundle: .module) : Text("Not selected", bundle: .module))
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
    }

    // MARK: - Actions
    private func select() {
        guard !isDisabled, !isSelected else { return }
        isSelected = true
    }
}

#if DEBUG
#Preview("RadioButtonAtom — All Variants") {
    @Previewable @State var selected1 = false
    @Previewable @State var selected2 = true
    @Previewable @State var selected3 = false

    VStack(alignment: .leading, spacing: 20) {
        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: $selected1, style: .default)
            Text(verbatim: "Option A").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: $selected2, style: .default)
            Text(verbatim: "Option B (Selected)").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: $selected3, isDisabled: true, style: .default)
            Text(verbatim: "Disabled").font(.body).foregroundStyle(.secondary)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: .constant(false), style: .modern)
            Text(verbatim: "Modern Style").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: .constant(false), style: .compact)
            Text(verbatim: "Compact Style").font(.body)
            Spacer()
        }
    }
    .padding()
}
#endif
