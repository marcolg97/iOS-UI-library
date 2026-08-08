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

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @ScaledMetric(relativeTo: .body) private var scale: CGFloat = 1

    // MARK: - Init
    public init(
        isOn: Binding<Bool>,
        isDisabled: Bool = false,
        style: SwitchAtomStyle = .default
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
                    .frame(width: style.trackWidth * scale, height: style.trackHeight * scale)

                Circle()
                    .fill(style.thumbColor)
                    .frame(width: style.thumbSize * scale, height: style.thumbSize * scale)
                    .offset(x: (isOn ? style.thumbOffset : -style.thumbOffset) * scale)
            }
            .frame(
                minWidth: max(style.trackWidth * scale, style.minTapTarget),
                minHeight: max(style.trackHeight * scale, style.minTapTarget)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityLabel(Text("Switch", bundle: .module))
        .accessibilityValue(isOn ? Text("On", bundle: .module) : Text("Off", bundle: .module))
        .accessibilityAddTraits(.isToggle)
        .animation(reduceMotion ? nil : .easeInOut(duration: 0.2), value: isOn)
    }

    // MARK: - Actions
    private func toggle() {
        guard !isDisabled else { return }
        isOn.toggle()
    }
}

#if DEBUG
#Preview("SwitchAtom — All Variants") {
    @Previewable @State var off = false
    @Previewable @State var on = true
    @Previewable @State var disabled = false

    VStack(alignment: .leading, spacing: 20) {
        HStack {
            Text(verbatim: "Off").font(.body)
            Spacer()
            SwitchAtom(isOn: $off, style: .default)
        }

        HStack {
            Text(verbatim: "On").font(.body)
            Spacer()
            SwitchAtom(isOn: $on, style: .default)
        }

        HStack {
            Text(verbatim: "Disabled").font(.body).foregroundStyle(.secondary)
            Spacer()
            SwitchAtom(isOn: $disabled, isDisabled: true, style: .default)
        }

        HStack {
            Text(verbatim: "Modern Style").font(.body)
            Spacer()
            SwitchAtom(isOn: .constant(true), style: .modern)
        }

        HStack {
            Text(verbatim: "Compact Style").font(.body)
            Spacer()
            SwitchAtom(isOn: .constant(false), style: .compact)
        }
    }
    .padding()
}
#endif
