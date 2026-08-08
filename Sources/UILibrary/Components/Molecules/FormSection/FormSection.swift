import SwiftUI

/// FormSection Molecule
///
/// Layer: Molecule
/// Responsibility: Groups related form items with optional header and footer.
/// Handles section spacing and styling.
public struct FormSection<Content: View>: View {
    // MARK: - Private stored properties
    private let header: LocalizedStringResource?
    private let footer: LocalizedStringResource?
    private let style: FormSectionStyle
    @ViewBuilder private let content: () -> Content

    // MARK: - Init
    public init(
        header: LocalizedStringResource? = nil,
        footer: LocalizedStringResource? = nil,
        style: FormSectionStyle = .default,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.header = header
        self.footer = footer
        self.style = style
        self.content = content
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: style.contentSpacing) {
            if let header = header {
                Text(header)
                    .font(style.headerFont)
                    .foregroundStyle(style.headerColor)
                    .textCase(style.headerTextCase)
                    .accessibilityAddTraits(.isHeader)
            }

            VStack(alignment: .leading, spacing: style.itemSpacing) {
                content()
            }

            if let footer = footer {
                Text(footer)
                    .font(style.footerFont)
                    .foregroundStyle(style.footerColor)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

#if DEBUG
#Preview("FormSection — Variants") {
    @Previewable @State var username = ""
    @Previewable @State var email = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var darkMode = false

    VStack(spacing: 32) {
        // Section with header
        FormSection(header: .verbatim("Account"), style: .default) {
            FormItem(layout: .vertical, style: .default) {
                FormLabel(.verbatim("Username"), style: .default)
                TextFieldAtom(text: $username, placeholder: .verbatim("Enter username"), style: .default)
            }

            FormItem(layout: .vertical, style: .default) {
                FormLabel(.verbatim("Email"), style: .default)
                TextFieldAtom(text: $email, placeholder: .verbatim("your@email.com"), style: .default)
            }
        }

        // Section with header and footer
        FormSection(
            header: .verbatim("Preferences"),
            footer: .verbatim("These settings affect your experience"),
            style: .default
        ) {
            FormItem(layout: .horizontal, style: .default) {
                FormLabel(.verbatim("Notifications"), style: .default)
                Spacer()
                SwitchAtom(isOn: $notificationsEnabled, style: .default)
            }

            FormItem(layout: .horizontal, style: .default) {
                FormLabel(.verbatim("Dark Mode"), style: .default)
                Spacer()
                SwitchAtom(isOn: $darkMode, style: .default)
            }
        }
    }
    .padding()
}
#endif
