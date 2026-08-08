import SwiftUI

/// FormHint Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic hint/help text for form fields.
/// Use within FormItem to provide guidance or context.
public struct FormHint: View {
    // MARK: - Public API
    public let text: LocalizedStringResource
    public let style: FormHintStyle

    // MARK: - Init
    public init(
        _ text: LocalizedStringResource,
        style: FormHintStyle = .default
    ) {
        self.text = text
        self.style = style
    }

    // MARK: - Body
    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundStyle(style.textColor)
    }
}

#if DEBUG
#Preview("FormHint — Variants") {
    VStack(alignment: .leading, spacing: 16) {
        FormHint(.verbatim("Enter your username (4-20 characters)"), style: .default)
        FormHint(.verbatim("This field is optional"), style: .default)
        FormHint(.verbatim("Modern style hint text"), style: .modern)
    }
    .padding()
}
#endif
