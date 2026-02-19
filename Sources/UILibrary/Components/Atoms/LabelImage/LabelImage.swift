import SwiftUI

/// A flexible component that displays a label with an icon in configurable positions.
///
/// This component provides a consistent way to display labels alongside icons,
/// with support for leading or trailing icon placement.
///
/// ## Usage
/// ```swift
/// // Using convenience initializer
/// LabelImage("Follow on Instagram", systemImage: "camera")
///
/// // With trailing icon
/// LabelImage("Rate on App Store", systemImage: "star.fill", style: .init(iconPosition: .trailing))
///
/// // Custom content
/// LabelImage(style: .init(iconPosition: .leading)) {
///     Text("Custom label")
///         .font(.headline)
/// } icon: {
///     Image(systemName: "sparkles")
///         .foregroundStyle(.tint)
/// }
/// ```
public struct LabelImage<LabelContent: View, IconContent: View>: View {
    private let style: LabelImageStyle

    /// The label content
    @ViewBuilder private let label: () -> LabelContent

    /// The icon content
    @ViewBuilder private let icon: () -> IconContent

    /// Creates a label-image component with custom content.
    ///
    /// - Parameters:
    ///   - style: `LabelImageStyle` that contains spacing and icon placement tokens.
    ///   - label: ViewBuilder for the label content
    ///   - icon: ViewBuilder for the icon content
    public init(
        style: LabelImageStyle = .neutral,
        @ViewBuilder label: @escaping () -> LabelContent,
        @ViewBuilder icon: @escaping () -> IconContent
    ) {
        self.style = style
        self.label = label
        self.icon = icon
    }
    
    var iconView: some View {
        icon()
            .foregroundColor(style.iconColor)
            .accessibilityHidden(style.hideIconFromAccessibility)
    }
    
    public var body: some View {
        HStack(spacing: style.spacing) {
            switch style.iconPosition {
            case .leading:
                iconView
                label()
            case .trailing:
                label()
                iconView
            }
        }
    }
}

public extension LabelImage where LabelContent == Text, IconContent == Image {
    /// Convenience initializer for Text and SF Symbol combinations.
    ///
    /// - Parameters:
    ///   - titleKey: Localized string key for the text
    ///   - systemImage: SF Symbol name for the icon
    ///   - style: `LabelImageStyle` used to configure spacing, placement and visual tokens.
    init(
        _ titleKey: LocalizedStringKey,
        systemImage: String,
        style: LabelImageStyle = .neutral
    ) {
        self.init(
            style: style
        ) {
            Text(titleKey)
                .font(style.font)
                .foregroundColor(style.textColor)
        } icon: {
            Image(systemName: systemImage)
        }
    }
}

#Preview("Default") {
    VStack(spacing: 12) {
        LabelImage("Follow on Instagram", systemImage: "camera")
        LabelImage("Rate on App Store", systemImage: "star.fill", style: .init(iconPosition: .trailing))
        LabelImage("Compact style", systemImage: "star.fill", style: .compact)
        LabelImage("4.5", systemImage: "star.fill", style: .init(hideIconFromAccessibility: false))
            .accessibilityLabel("Rating: 4.5 stars")
    }
    
    LabelImage(style: .init(iconPosition: .leading)) {
        Text("Custom label")
            .font(.headline)
    } icon: {
        Image(systemName: "sparkles")
            .foregroundStyle(.tint)
    }
}
