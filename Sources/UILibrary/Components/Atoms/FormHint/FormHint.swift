import SwiftUI

/// FormHint Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic hint/help text for form fields.
/// Use within FormItem to provide guidance or context.
public struct FormHint: View {
    // MARK: - Public API
    public let text: String
    public let style: FormHintStyle
    
    // MARK: - Init
    public init(
        _ text: String,
        style: FormHintStyle
    ) {
        self.text = text
        self.style = style
    }
    
    // MARK: - Body
    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundStyle(style.textColor)
            .accessibilityLabel(text)
    }
}

#Preview("FormHint — Variants") {
    VStack(alignment: .leading, spacing: 16) {
        FormHint("Enter your username (4-20 characters)", style: .previewDefault)
        FormHint("This field is optional", style: .previewDefault)
        FormHint("Modern style hint text", style: .modern)
    }
    .padding()
}
