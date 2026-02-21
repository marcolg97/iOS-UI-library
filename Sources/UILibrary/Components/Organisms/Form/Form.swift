import SwiftUI

/// Form Organism
///
/// Layer: Organism
/// Responsibility: Top-level container for form sections, providing consistent spacing and optional styling.
/// Use as the root container for all form-based UIs.
public struct Form<Content: View>: View {
    // MARK: - Public API
    public let style: FormStyle
    @ViewBuilder public let content: () -> Content
    
    // MARK: - Init
    public init(
        style: FormStyle,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = style
        self.content = content
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: style.sectionSpacing) {
            content()
        }
        .padding(style.padding)
        .background(style.backgroundColor ?? Color.clear)
    }
}

#Preview("Form — Complete Example") {
    @Previewable @State var username = ""
    @Previewable @State var email = ""
    @Previewable @State var password = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var darkMode = false
    @Previewable @State var acceptTerms = false
    
    ScrollView {
        Form(style: .previewDefault) {
            FormSection(header: "Account", style: .previewDefault) {
                FormItem(layout: .vertical, style: .previewDefault) {
                    FormLabel("Username", systemImage: "person", style: .previewDefault)
                    TextFieldAtom(text: $username, placeholder: "Enter username", style: .previewDefault)
                    FormHint("Between 4-20 characters", style: .previewDefault)
                }
                
                FormItem(layout: .vertical, style: .previewDefault) {
                    FormLabel("Email", systemImage: "envelope", style: .previewDefault)
                    TextFieldAtom(text: $email, placeholder: "your@email.com", style: .previewDefault)
                }
                
                FormItem(layout: .vertical, style: .previewDefault) {
                    FormLabel("Password", systemImage: "lock", style: .previewDefault)
                    TextFieldAtom(text: $password, placeholder: "Enter password", style: .previewDefault)
                    FormError("Password must be at least 8 characters", style: .previewDefault)
                }
            }
            
            FormSection(
                header: "Preferences",
                footer: "These settings affect your app experience",
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
            
            FormSection(style: .previewDefault) {
                FormItem(layout: .horizontal, style: .previewDefault) {
                    CheckboxAtom(isOn: $acceptTerms, style: .previewDefault)
                    FormLabel("I accept the terms and conditions", style: .previewDefault)
                }
            }
        }
    }
}

#Preview("Form — Modern Style") {
    @Previewable @State var name = ""
    @Previewable @State var email = ""
    @Previewable @State var password = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var darkMode = false
    @Previewable @State var acceptTerms = false
    @Previewable @State var error: String? = "Password must be at least 8 characters"

    ScrollView {
        Form(style: .modern) {
            FormSection(header: "Personal Info", style: .modern) {
                FormItem(layout: .vertical, style: .spacious) {
                    FormLabel("FULL NAME", systemImage: "person", style: .modern)
                    TextFieldAtom(text: $name, placeholder: "John Doe", style: .modern)
                }
                FormItem(layout: .vertical, style: .spacious) {
                    FormLabel("Email Address", systemImage: "envelope", style: .modern)
                    TextFieldAtom(text: $email, placeholder: "john@example.com", style: .modern)
                    FormHint("We'll never share your email", style: .modern)
                }
                FormItem(layout: .vertical, style: .spacious) {
                    FormLabel("Password", systemImage: "lock", style: .modern)
                    TextFieldAtom(text: $password, placeholder: "Enter password", hasError: error != nil, style: .modern)
                    if let error = error {
                        FormError(error, style: .modern)
                    }
                }
            }
            FormSection(header: "Preferences", footer: "These settings affect your app experience", style: .modern) {
                FormItem(layout: .horizontal, style: .spacious) {
                    FormLabel("Notifications", style: .modern)
                    Spacer()
                    SwitchAtom(isOn: $notificationsEnabled, style: .modern)
                }
                FormItem(layout: .horizontal, style: .spacious) {
                    FormLabel("Dark Mode", style: .modern)
                    Spacer()
                    SwitchAtom(isOn: $darkMode, style: .modern)
                }
            }
            FormSection(style: .modern) {
                FormItem(layout: .horizontal, style: .spacious) {
                    CheckboxAtom(isOn: $acceptTerms, style: .modern)
                    FormLabel("I accept the terms and conditions", style: .modern)
                }
            }
        }
    }
}
