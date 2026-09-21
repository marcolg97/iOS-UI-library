//
//  SettingsRow.swift
//  UILibrary
//

import SwiftUI

/// SettingsRow Molecule
///
/// Layer: Molecule
/// Responsibility: One tappable line in a settings list — a leading symbol, a title with an
/// optional subtitle, an optional accessory (a count, a status word, a `Switch`) and a chevron.
///
/// Unlike `ListItemCard`, a `SettingsRow` draws no surface of its own: it is meant to sit inside
/// `SettingsGroup`, which supplies the one shared card and the dividers between rows. Use
/// `ListItemCard` when a row *is* its own card, and `SettingsRow` when several rows share one.
///
/// ## Usage
/// ```swift
/// SettingsGroup(header: .verbatim("Preferences"), rows: [
///     SettingsRow(id: "dietary", systemImage: "leaf", title: .verbatim("Allergies")) { open() },
///     SettingsRow(id: "alerts", systemImage: "bell", title: .verbatim("Reminders")) {
///         Text(verbatim: "On")
///     } action: {
///         open()
///     },
/// ])
/// ```
///
/// ## Accessibility
/// The row is a single button. `id` is applied as its accessibility identifier, and the accessory
/// keeps whatever identifier the caller puts on it, so a UI test can read a count or a status
/// without the row's own identifier getting in the way.
public struct SettingsRow: View, Identifiable {
    // MARK: - Private stored properties
    private let systemImage: String
    private let title: LocalizedStringResource
    private let subtitle: LocalizedStringResource?
    private let accessory: AnyView
    private let style: SettingsRowStyle
    private let action: () -> Void

    /// Identifies the row inside its group, and doubles as its accessibility identifier.
    public let id: String

    // MARK: - Init

    /// Creates a row with an accessory view between the text and the chevron.
    /// - Parameters:
    ///   - id: Identifies the row in its group and is applied as its accessibility identifier.
    ///   - systemImage: SF Symbol shown at the leading edge.
    ///   - title: The row's title.
    ///   - subtitle: An optional second line, for a row that needs a word of explanation.
    ///   - style: Visual tokens.
    ///   - accessory: Shown just before the chevron — a count, a status word, a control.
    ///   - action: Run when the row is tapped.
    public init<Accessory: View>(
        id: String,
        systemImage: String,
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource? = nil,
        style: SettingsRowStyle = .default,
        @ViewBuilder accessory: () -> Accessory,
        action: @escaping () -> Void
    ) {
        self.id = id
        self.systemImage = systemImage
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.accessory = AnyView(accessory())
        self.action = action
    }

    /// Creates a row with no accessory.
    public init(
        id: String,
        systemImage: String,
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource? = nil,
        style: SettingsRowStyle = .default,
        action: @escaping () -> Void
    ) {
        self.init(
            id: id, systemImage: systemImage, title: title, subtitle: subtitle, style: style,
            accessory: { EmptyView() }, action: action
        )
    }

    // MARK: - Body
    public var body: some View {
        Button(action: action) {
            HStack(spacing: style.contentSpacing) {
                Image(systemName: systemImage)
                    .font(style.symbolFont)
                    .foregroundStyle(style.symbolColor)
                    .frame(width: style.symbolWidth)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(style.titleFont)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(style.titleColor)
                    if let subtitle {
                        Text(subtitle)
                            .font(style.subtitleFont)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(style.subtitleColor)
                    }
                }
                Spacer(minLength: 8)
                accessory
                if let disclosureSystemName = style.disclosureSystemName {
                    Image(systemName: disclosureSystemName)
                        .font(style.disclosureFont)
                        .foregroundStyle(style.disclosureColor)
                }
            }
            .padding(style.padding)
            .contentShape(.rect)
        }
        .buttonStyle(PressScaleButtonStyle(pressedScale: style.pressedScale))
        .accessibilityIdentifier(id)
    }
}

#if DEBUG
#Preview("SettingsRow — variants") {
    VStack(spacing: 0) {
        SettingsRow(id: "plain", systemImage: "leaf", title: .verbatim("Allergies and intolerances")) {}
        DividerAtom(style: DividerStyle(leadingInset: SettingsRowStyle.default.textInset))
        SettingsRow(id: "count", systemImage: "person.2", title: .verbatim("Co-hosts")) {
            Text(verbatim: "2").foregroundStyle(.secondary)
        } action: {}
        DividerAtom(style: DividerStyle(leadingInset: SettingsRowStyle.default.textInset))
        SettingsRow(
            id: "subtitle", systemImage: "bell", title: .verbatim("Reminders"),
            subtitle: .verbatim("A nudge before your events, and when guests answer")
        ) {
            Text(verbatim: "On").foregroundStyle(.green)
        } action: {}
        DividerAtom(style: DividerStyle(leadingInset: SettingsRowStyle.default.textInset))
        SettingsRow(id: "no-chevron", systemImage: "moon", title: .verbatim("Dark mode"), style: .plain) {
            Text(verbatim: "Off").foregroundStyle(.secondary)
        } action: {}
    }
    .background(Color.primary.opacity(0.05), in: RoundedRectangle(cornerRadius: 16))
    .padding()
}
#endif
