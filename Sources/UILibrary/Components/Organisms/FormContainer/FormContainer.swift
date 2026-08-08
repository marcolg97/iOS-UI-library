import SwiftUI

/// FormContainer Organism
///
/// Layer: Organism
/// Responsibility: Top-level container for form sections, providing consistent spacing and optional styling.
/// Use as the root container for all form-based UIs.
///
/// Named `FormContainer` (not `Form`) to avoid ambiguity with `SwiftUI.Form`.
///
/// - Note: `FormContainer` does not scroll by itself. Embed it in a `ScrollView`
///   when the form can exceed the available height, so the keyboard does not
///   obscure focused fields.
public struct FormContainer<Content: View>: View {
    // MARK: - Private stored properties
    private let style: FormContainerStyle
    @ViewBuilder private let content: () -> Content

    // MARK: - Init
    public init(
        style: FormContainerStyle = .default,
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

#if DEBUG
#Preview("FormContainer — Complete Example") {
    @Previewable @State var username = ""
    @Previewable @State var email = ""
    @Previewable @State var password = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var darkMode = false
    @Previewable @State var acceptTerms = false

    ScrollView {
        FormContainer(style: .default) {
            FormSection(header: .verbatim("Account"), style: .default) {
                FormItem(layout: .vertical, style: .default) {
                    FormLabel(.verbatim("Username"), systemImage: "person", style: .default)
                    TextFieldAtom(text: $username, placeholder: .verbatim("Enter username"), style: .default)
                    FormHint(.verbatim("Between 4-20 characters"), style: .default)
                }

                FormItem(layout: .vertical, style: .default) {
                    FormLabel(.verbatim("Email"), systemImage: "envelope", style: .default)
                    TextFieldAtom(text: $email, placeholder: .verbatim("your@email.com"), style: .default)
                }

                FormItem(layout: .vertical, style: .default) {
                    FormLabel(.verbatim("Password"), systemImage: "lock", style: .default)
                    TextFieldAtom(text: $password, placeholder: .verbatim("Enter password"), style: .default)
                    FormError(.verbatim("Password must be at least 8 characters"), style: .default)
                }
            }

            FormSection(
                header: .verbatim("Preferences"),
                footer: .verbatim("These settings affect your app experience"),
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

            FormSection(style: .default) {
                FormItem(layout: .horizontal, style: .default) {
                    CheckboxAtom(isOn: $acceptTerms, style: .default)
                    FormLabel(.verbatim("I accept the terms and conditions"), style: .default)
                }
            }
        }
    }
}

#Preview("FormContainer — Modern Style") {
    @Previewable @State var name = ""
    @Previewable @State var email = ""
    @Previewable @State var password = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var darkMode = false
    @Previewable @State var acceptTerms = false
    @Previewable @State var error: String? = "Password must be at least 8 characters"

    ScrollView {
        FormContainer(style: .modern) {
            FormSection(header: .verbatim("Personal Info"), style: .modern) {
                FormItem(layout: .vertical, style: .spacious) {
                    FormLabel(.verbatim("FULL NAME"), systemImage: "person", style: .modern)
                    TextFieldAtom(text: $name, placeholder: .verbatim("John Doe"), style: .modern)
                }
                FormItem(layout: .vertical, style: .spacious) {
                    FormLabel(.verbatim("Email Address"), systemImage: "envelope", style: .modern)
                    TextFieldAtom(text: $email, placeholder: .verbatim("john@example.com"), style: .modern)
                    FormHint(.verbatim("We'll never share your email"), style: .modern)
                }
                FormItem(layout: .vertical, style: .spacious) {
                    FormLabel(.verbatim("Password"), systemImage: "lock", style: .modern)
                    TextFieldAtom(text: $password, placeholder: .verbatim("Enter password"), hasError: error != nil, style: .modern)
                    if let error = error {
                        FormError(.verbatim(error), style: .modern)
                    }
                }
            }
            FormSection(
                header: .verbatim("Preferences"),
                footer: .verbatim("These settings affect your app experience"),
                style: .modern
            ) {
                FormItem(layout: .horizontal, style: .spacious) {
                    FormLabel(.verbatim("Notifications"), style: .modern)
                    Spacer()
                    SwitchAtom(isOn: $notificationsEnabled, style: .modern)
                }
                FormItem(layout: .horizontal, style: .spacious) {
                    FormLabel(.verbatim("Dark Mode"), style: .modern)
                    Spacer()
                    SwitchAtom(isOn: $darkMode, style: .modern)
                }
            }
            FormSection(style: .modern) {
                FormItem(layout: .horizontal, style: .spacious) {
                    CheckboxAtom(isOn: $acceptTerms, style: .modern)
                    FormLabel(.verbatim("I accept the terms and conditions"), style: .modern)
                }
            }
        }
    }
}
#endif
