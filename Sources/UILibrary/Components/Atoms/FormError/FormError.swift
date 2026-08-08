import SwiftUI

/// FormError Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic error message text for form fields.
/// Use within FormItem to display validation errors.
public struct FormError: View {
    // MARK: - Public API
    public let text: LocalizedStringResource
    public let style: FormErrorStyle

    // MARK: - Init
    public init(
        _ text: LocalizedStringResource,
        style: FormErrorStyle = .default
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
                    .accessibilityHidden(true)
            }

            Text(text)
                .font(style.font)
                .foregroundStyle(style.textColor)
        }
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("FormError — Variants") {
    VStack(alignment: .leading, spacing: 16) {
        FormError(.verbatim("This field is required"), style: .default)
        FormError(.verbatim("Invalid email address"), style: .default)
        FormError(.verbatim("Password must be at least 8 characters"), style: .modern)
    }
    .padding()
}
#endif
