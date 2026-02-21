import SwiftUI

/// FormError Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic error message text for form fields.
/// Use within FormItem to display validation errors.
public struct FormError: View {
    // MARK: - Public API
    public let text: String
    public let style: FormErrorStyle
    
    // MARK: - Init
    public init(
        _ text: String,
        style: FormErrorStyle
    ) {
        self.text = text
        self.style = style
    }
    
    // MARK: - Body
    public var body: some View {
        HStack(spacing: style.iconSpacing) {
            if let systemImage = style.iconSystemName {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: style.iconSize, height: style.iconSize)
                    .foregroundStyle(style.textColor)
            }
            
            Text(text)
                .font(style.font)
                .foregroundStyle(style.textColor)
        }
        .accessibilityLabel(text)
    }
}

#Preview("FormError — Variants") {
    VStack(alignment: .leading, spacing: 16) {
        FormError("This field is required", style: .previewDefault)
        FormError("Invalid email address", style: .previewDefault)
        FormError("Password must be at least 8 characters", style: .modern)
    }
    .padding()
}
