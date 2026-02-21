import SwiftUI

/// FormLabel Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic label for form fields with optional icon.
/// Use within FormItem or standalone for custom layouts.
public struct FormLabel: View {
    // MARK: - Public API
    public let text: String
    public let systemImage: String?
    public let style: FormLabelStyle
    
    // MARK: - Init
    public init(
        _ text: String,
        systemImage: String? = nil,
        style: FormLabelStyle
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
            }
            
            Text(text)
                .font(style.font)
                .tracking(style.tracking)
                .foregroundStyle(style.textColor)
        }
        .accessibilityLabel(text)
    }
}

#Preview("FormLabel — Variants") {
    VStack(alignment: .leading, spacing: 16) {
        FormLabel("Username", style: .previewDefault)
        FormLabel("Email", systemImage: "envelope", style: .previewDefault)
        FormLabel("Password", systemImage: "lock", style: .previewDefault)
        FormLabel("Modern Style", systemImage: "star.fill", style: .modern)
    }
    .padding()
}
