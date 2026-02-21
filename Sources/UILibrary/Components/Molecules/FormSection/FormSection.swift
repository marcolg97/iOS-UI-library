import SwiftUI

/// FormSection Molecule
///
/// Layer: Molecule
/// Responsibility: Groups related form items with optional header and footer.
/// Handles section spacing and styling.
public struct FormSection<Content: View>: View {
    // MARK: - Public API
    public let header: String?
    public let footer: String?
    public let style: FormSectionStyle
    @ViewBuilder public let content: () -> Content
    
    // MARK: - Init
    public init(
        header: String? = nil,
        footer: String? = nil,
        style: FormSectionStyle,
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
    }
}

#Preview("FormSection — Variants") {
    @Previewable @State var username = ""
    @Previewable @State var email = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var darkMode = false
    
    VStack(spacing: 32) {
        // Section with header
        FormSection(header: "Account", style: .previewDefault) {
            FormItem(layout: .vertical, style: .previewDefault) {
                FormLabel("Username", style: .previewDefault)
                TextFieldAtom(text: $username, placeholder: "Enter username", style: .previewDefault)
            }
            
            FormItem(layout: .vertical, style: .previewDefault) {
                FormLabel("Email", style: .previewDefault)
                TextFieldAtom(text: $email, placeholder: "your@email.com", style: .previewDefault)
            }
        }
        
        // Section with header and footer
        FormSection(
            header: "Preferences",
            footer: "These settings affect your experience",
            style: .previewDefault
        ) {
            FormItem(layout: .horizontal, style: .previewDefault) {
                FormLabel("Notifications", style: .previewDefault)
                Spacer()
                SwitchAtom(isOn: $notificationsEnabled, style: .previewDefault)
            }
            
            FormItem(layout: .horizontal, style: .previewDefault) {
                FormLabel("Dark Mode", style: .previewDefault)
                Spacer()
                SwitchAtom(isOn: $darkMode, style: .previewDefault)
            }
        }
    }
    .padding()
}
