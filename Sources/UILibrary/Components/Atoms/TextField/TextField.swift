import SwiftUI

/// TextField Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected single-line input field.
/// Pure input control without labels, hints, or error states. Compose with FormLabel, FormHint, and FormError.
public struct TextFieldAtom: View {
    // MARK: - Public API
    public let style: TextFieldAtomStyle
    public let placeholder: LocalizedStringResource?
    public let isDisabled: Bool
    public let hasError: Bool

    // MARK: - Bindings / State
    @Binding public var text: String
    @FocusState private var isFocused: Bool

    // MARK: - Init
    public init(
        text: Binding<String>,
        placeholder: LocalizedStringResource? = nil,
        isDisabled: Bool = false,
        hasError: Bool = false,
        style: TextFieldAtomStyle = .default
    ) {
        self.style = style
        self.placeholder = placeholder
        self.isDisabled = isDisabled
        self.hasError = hasError
        self._text = text
    }

    // MARK: - Body
    public var body: some View {
        TextField(
            text: $text,
            prompt: placeholder.map { Text($0).foregroundStyle(style.placeholderColor) }
        ) {
            EmptyView()
        }
        .disabled(isDisabled)
        .font(style.font)
        .foregroundStyle(style.textColor)
        .padding(style.padding)
        .focused($isFocused)
        .background(style.backgroundColor, in: RoundedRectangle(cornerRadius: style.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: style.cornerRadius)
                .stroke(
                    hasError ? style.errorBorderColor : (isFocused ? style.focusedBorderColor : style.borderColor),
                    lineWidth: style.borderWidth
                )
        )
        .opacity(isDisabled ? style.disabledOpacity : 1)
        .accessibilityLabel(placeholder.map { Text($0) } ?? Text("Text field", bundle: .module))
    }
}

#if DEBUG
#Preview("TextFieldAtom — All Variants") {
    @Previewable @State var text1 = ""
    @Previewable @State var text2 = "Some text"
    @Previewable @State var text3 = ""
    @Previewable @State var text4 = "Error text"

    VStack(alignment: .leading, spacing: 20) {
        Group {
            Text(verbatim: "Default").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text1,
                placeholder: .verbatim("Enter text"),
                style: .default
            )
        }

        Group {
            Text(verbatim: "With Value").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text2,
                placeholder: .verbatim("Enter text"),
                style: .default
            )
        }

        Group {
            Text(verbatim: "Disabled").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text3,
                placeholder: .verbatim("Enter text"),
                isDisabled: true,
                style: .default
            )
        }

        Group {
            Text(verbatim: "Error State").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text4,
                placeholder: .verbatim("Enter text"),
                hasError: true,
                style: .default
            )
        }

        Group {
            Text(verbatim: "Modern").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: .constant(""),
                placeholder: .verbatim("Modern style"),
                style: .modern
            )
        }

        Group {
            Text(verbatim: "Compact").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: .constant(""),
                placeholder: .verbatim("Compact"),
                style: .compact
            )
        }
    }
    .padding()
}
#endif
