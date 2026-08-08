import SwiftUI

/// Checkbox Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected binary toggle.
/// Pure checkbox control without labels, hints, or error states. Compose with FormLabel, FormHint, and FormError.
public struct CheckboxAtom: View {
    // MARK: - Public API
    @Binding public var isOn: Bool
    public let isDisabled: Bool
    public let style: CheckboxStyle

    @ScaledMetric(relativeTo: .body) private var scale: CGFloat = 1

    // MARK: - Init
    public init(
        isOn: Binding<Bool>,
        isDisabled: Bool = false,
        style: CheckboxStyle = .default
    ) {
        self._isOn = isOn
        self.isDisabled = isDisabled
        self.style = style
    }

    // MARK: - Body
    public var body: some View {
        Button(action: toggle) {
            ZStack {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .fill(isOn ? style.fillColor : style.backgroundColor)
                    .frame(width: style.boxSize * scale, height: style.boxSize * scale)
                    .overlay(
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .stroke(isOn ? style.fillColor : style.borderColor, lineWidth: style.borderWidth)
                    )

                if isOn {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(style.checkmarkColor)
                        .frame(width: style.checkmarkSize * scale, height: style.checkmarkSize * scale)
                }
            }
            .frame(
                minWidth: max(style.boxSize * scale, style.minTapTarget),
                minHeight: max(style.boxSize * scale, style.minTapTarget)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityLabel(Text("Checkbox", bundle: .module))
        .accessibilityValue(isOn ? Text("Checked", bundle: .module) : Text("Unchecked", bundle: .module))
        .accessibilityAddTraits(.isToggle)
    }

    // MARK: - Actions
    private func toggle() {
        guard !isDisabled else { return }
        isOn.toggle()
    }
}

#if DEBUG
#Preview("CheckboxAtom — All Variants") {
    @Previewable @State var unchecked = false
    @Previewable @State var checked = true
    @Previewable @State var disabled = false

    VStack(alignment: .leading, spacing: 20) {
        HStack(spacing: 12) {
            CheckboxAtom(isOn: $unchecked, style: .default)
            Text(verbatim: "Unchecked").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            CheckboxAtom(isOn: $checked, style: .default)
            Text(verbatim: "Checked").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            CheckboxAtom(isOn: $disabled, isDisabled: true, style: .default)
            Text(verbatim: "Disabled").font(.body).foregroundStyle(.secondary)
            Spacer()
        }

        HStack(spacing: 12) {
            CheckboxAtom(isOn: .constant(false), style: .modern)
            Text(verbatim: "Modern Style").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            CheckboxAtom(isOn: .constant(false), style: .compact)
            Text(verbatim: "Compact Style").font(.body)
            Spacer()
        }
    }
    .padding()
}
#endif
