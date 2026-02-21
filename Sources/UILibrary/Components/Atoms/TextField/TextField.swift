import SwiftUI

/// TextField Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected single-line input field.
/// Pure input control without labels, hints, or error states. Compose with FormLabel, FormHint, and FormError.
public struct TextFieldAtom: View {
    // MARK: - Public API
    public let style: TextFieldAtomStyle
    public let placeholder: String?
    public let isDisabled: Bool
    public let hasError: Bool
    
    // MARK: - Bindings / State
    @Binding public var text: String
    @FocusState private var isFocused: Bool

    // MARK: - Init
    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        isDisabled: Bool = false,
        hasError: Bool = false,
        style: TextFieldAtomStyle
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
            "",
            text: $text,
            prompt: (placeholder != nil) ? Text(placeholder!) : nil
        )
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
        .accessibilityLabel(placeholder ?? "Text field")
    }
}


#Preview("TextFieldAtom — All Variants") {
    @Previewable @State var text1 = ""
    @Previewable @State var text2 = "Some text"
    @Previewable @State var text3 = ""
    @Previewable @State var text4 = "Error text"
    
    VStack(alignment: .leading, spacing: 20) {
        Group {
            Text("Default").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text1,
                placeholder: "Enter text",
                style: .previewDefault
            )
        }

        Group {
            Text("With Value").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text2,
                placeholder: "Enter text",
                style: .previewDefault
            )
        }

        Group {
            Text("Disabled").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text3,
                placeholder: "Enter text",
                isDisabled: true,
                style: .previewDefault
            )
        }

        Group {
            Text("Error State").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: $text4,
                placeholder: "Enter text",
                hasError: true,
                style: .previewDefault
            )
        }

        Group {
            Text("Modern").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: .constant(""),
                placeholder: "Modern style",
                style: .modern
            )
        }

        Group {
            Text("Compact").font(.caption).foregroundStyle(.secondary)
            TextFieldAtom(
                text: .constant(""),
                placeholder: "Compact",
                style: .compact
            )
        }
    }
    .padding()
}

