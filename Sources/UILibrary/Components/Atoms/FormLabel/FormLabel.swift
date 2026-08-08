import SwiftUI

/// FormLabel Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic label for form fields with optional icon.
/// Use within FormItem or standalone for custom layouts.
public struct FormLabel: View {
    // MARK: - Public API
    public let text: LocalizedStringResource
    public let systemImage: String?
    public let style: FormLabelStyle

    // MARK: - Init
    public init(
        _ text: LocalizedStringResource,
        systemImage: String? = nil,
        style: FormLabelStyle = .default
    ) {
        self.text = text
        self.systemImage = systemImage
        self.style = style
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: style.iconSpacing) {
            if let systemImage = systemImage {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: style.iconSize, height: style.iconSize)
                    .foregroundStyle(style.iconColor)
                    .accessibilityHidden(true)
            }

            Text(text)
                .font(style.font)
                .tracking(style.tracking)
                .foregroundStyle(style.textColor)
        }
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("FormLabel — Variants") {
    VStack(alignment: .leading, spacing: 16) {
        FormLabel(.verbatim("Username"), style: .default)
        FormLabel(.verbatim("Email"), systemImage: "envelope", style: .default)
        FormLabel(.verbatim("Password"), systemImage: "lock", style: .default)
        FormLabel(.verbatim("Modern Style"), systemImage: "star.fill", style: .modern)
    }
    .padding()
}
#endif
