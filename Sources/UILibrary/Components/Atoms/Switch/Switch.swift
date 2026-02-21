import SwiftUI

/// Switch Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected on/off toggle.
/// Pure switch control without labels, hints, or error states. Compose with FormLabel, FormHint, and FormError.
public struct SwitchAtom: View {
    // MARK: - Public API
    @Binding public var isOn: Bool
    public let isDisabled: Bool
    public let style: SwitchAtomStyle

    // MARK: - Init
    public init(
        isOn: Binding<Bool>,
        isDisabled: Bool = false,
        style: SwitchAtomStyle
    ) {
        self._isOn = isOn
        self.isDisabled = isDisabled
        self.style = style
    }

    // MARK: - Body
    public var body: some View {
        Button(action: toggle) {
            ZStack {
                Capsule()
                    .fill(isOn ? style.trackOnColor : style.trackOffColor)
                    .frame(width: style.trackWidth, height: style.trackHeight)

                Circle()
                    .fill(style.thumbColor)
                    .frame(width: style.thumbSize, height: style.thumbSize)
                    .offset(x: isOn ? style.thumbOffset : -style.thumbOffset)
            }
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityLabel("Switch")
        .accessibilityValue(isOn ? "On" : "Off")
        .accessibilityAddTraits(.isButton)
        .animation(.easeInOut(duration: 0.2), value: isOn)
    }

    // MARK: - Actions
    private func toggle() {
        guard !isDisabled else { return }
        isOn.toggle()
    }
}


#Preview("SwitchAtom — All Variants") {
    @Previewable @State var off = false
    @Previewable @State var on = true
    @Previewable @State var disabled = false
    
    VStack(alignment: .leading, spacing: 20) {
        HStack {
            Text("Off").font(.body)
            Spacer()
            SwitchAtom(isOn: $off, style: .previewDefault)
        }

        HStack {
            Text("On").font(.body)
            Spacer()
            SwitchAtom(isOn: $on, style: .previewDefault)
        }

        HStack {
            Text("Disabled").font(.body).foregroundStyle(.secondary)
            Spacer()
            SwitchAtom(isOn: $disabled, isDisabled: true, style: .previewDefault)
        }

        HStack {
            Text("Modern Style").font(.body)
            Spacer()
            SwitchAtom(isOn: .constant(true), style: .modern)
        }

        HStack {
            Text("Compact Style").font(.body)
            Spacer()
            SwitchAtom(isOn: .constant(false), style: .compact)
        }
    }
    .padding()
}
