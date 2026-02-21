import SwiftUI

/// RadioButton Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected single-choice selector.
/// Pure radio button control without labels, hints, or error states. Compose with FormLabel, FormHint, and FormError.
public struct RadioButtonAtom: View {
    // MARK: - Public API
    @Binding public var isSelected: Bool
    public let isDisabled: Bool
    public let style: RadioButtonStyle

    // MARK: - Init
    public init(
        isSelected: Binding<Bool>,
        isDisabled: Bool = false,
        style: RadioButtonStyle
    ) {
        self._isSelected = isSelected
        self.isDisabled = isDisabled
        self.style = style
    }

    // MARK: - Body
    public var body: some View {
        Button(action: toggle) {
            ZStack {
                Circle()
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
                    .frame(width: style.outerSize, height: style.outerSize)
                    .background(Circle().fill(style.backgroundColor).frame(width: style.outerSize, height: style.outerSize))

                if isSelected {
                    Circle()
                        .fill(style.fillColor)
                        .frame(width: style.innerSize, height: style.innerSize)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityLabel("Radio button")
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Actions
    private func toggle() {
        guard !isDisabled else { return }
        isSelected.toggle()
    }
}


#Preview("RadioButtonAtom — All Variants") {
    @Previewable @State var selected1 = false
    @Previewable @State var selected2 = true
    @Previewable @State var selected3 = false
    
    VStack(alignment: .leading, spacing: 20) {
        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: $selected1, style: .previewDefault)
            Text("Option A").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: $selected2, style: .previewDefault)
            Text("Option B (Selected)").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: $selected3, isDisabled: true, style: .previewDefault)
            Text("Disabled").font(.body).foregroundStyle(.secondary)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: .constant(false), style: .modern)
            Text("Modern Style").font(.body)
            Spacer()
        }

        HStack(spacing: 12) {
            RadioButtonAtom(isSelected: .constant(false), style: .compact)
            Text("Compact Style").font(.body)
            Spacer()
        }
    }
    .padding()
}
