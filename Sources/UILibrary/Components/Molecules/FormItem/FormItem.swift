import SwiftUI

/// FormItem Molecule
///
/// Layer: Molecule
/// Responsibility: Layout container for a single form field with label, input, and optional hint/error.
/// Supports horizontal and vertical layouts. Purely structural—no visual styling.
public struct FormItem<Content: View>: View {
    // MARK: - Public API
    public let layout: FormItemLayout
    public let style: FormItemStyle
    @ViewBuilder public let content: () -> Content
    
    // MARK: - Init
    public init(
        layout: FormItemLayout = .vertical,
        style: FormItemStyle,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.layout = layout
        self.style = style
        self.content = content
    }
    
    // MARK: - Body
    public var body: some View {
        Group {
            switch layout {
            case .vertical:
                VStack(alignment: .leading, spacing: style.spacing) {
                    content()
                }
            case .horizontal:
                HStack(alignment: .center, spacing: style.spacing) {
                    content()
                }
            }
        }
    }
}

/// Layout options for FormItem
public enum FormItemLayout: Equatable {
    case vertical
    case horizontal
}

#Preview("FormItem — Layouts") {
    @Previewable @State var username = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var acceptTerms = false
    
    VStack(spacing: 24) {
        // Vertical layout (default)
        FormItem(layout: .vertical, style: .previewDefault) {
            FormLabel("Username", systemImage: "person", style: .previewDefault)
            TextFieldAtom(text: $username, placeholder: "Enter username", style: .previewDefault)
            FormHint("Between 4-20 characters", style: .previewDefault)
        }
        
        // Horizontal layout
        FormItem(layout: .horizontal, style: .previewDefault) {
            FormLabel("Notifications", style: .previewDefault)
            Spacer()
            SwitchAtom(isOn: $notificationsEnabled, style: .previewDefault)
        }
        
        // Horizontal with checkbox
        FormItem(layout: .horizontal, style: .previewDefault) {
            CheckboxAtom(isOn: $acceptTerms, style: .previewDefault)
            FormLabel("Accept terms and conditions", style: .previewDefault)
        }
        
        // With error
        FormItem(layout: .vertical, style: .previewDefault) {
            FormLabel("Email", systemImage: "envelope", style: .previewDefault)
            TextFieldAtom(text: .constant("invalid"), placeholder: "your@email.com", style: .previewDefault)
            FormError("Invalid email address", style: .previewDefault)
        }
    }
    .padding()
}
