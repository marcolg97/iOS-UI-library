//
//  SettingsGroup.swift
//  UILibrary
//

import SwiftUI

/// SettingsGroup Organism
///
/// Layer: Organism
/// Responsibility: A titled group of `SettingsRow`s sharing one surface, with dividers between
/// them — the settings idiom, as opposed to `ListItemCard`'s one-card-per-row.
///
/// ## Why rows are values, not a `@ViewBuilder`
/// The group has to know where the row boundaries are so a divider goes *between* rows and never
/// under the last one, and SwiftUI offers no public way to take a view builder apart. Passing
/// `[SettingsRow]` makes the boundaries explicit, and it keeps the divider inset in step with the
/// rows' own `textInset`.
///
/// ## Usage
/// ```swift
/// SettingsGroup(header: .verbatim("Preferences"), rows: [
///     SettingsRow(id: "dietary", systemImage: "leaf", title: .verbatim("Allergies")) { open() },
///     SettingsRow(id: "alerts", systemImage: "bell", title: .verbatim("Reminders")) { ask() },
/// ])
/// ```
///
/// An empty `rows` array renders nothing at all, header included, so a caller can filter rows by
/// feature flag without also having to decide whether the group still has anything to show.
public struct SettingsGroup: View {
    // MARK: - Private stored properties
    private let header: LocalizedStringResource?
    private let rows: [SettingsRow]
    private let style: SettingsGroupStyle
    private let rowStyle: SettingsRowStyle

    // MARK: - Init

    /// Creates a settings group.
    /// - Parameters:
    ///   - header: Optional group title, shown above the surface.
    ///   - rows: The rows, in order. An empty array renders nothing.
    ///   - style: Visual tokens for the group.
    ///   - rowStyle: The style the rows were built with, used to line the dividers up with their
    ///     text. Pass the same value here that the rows use.
    public init(
        header: LocalizedStringResource? = nil,
        rows: [SettingsRow],
        style: SettingsGroupStyle = .default,
        rowStyle: SettingsRowStyle = .default
    ) {
        self.header = header
        self.rows = rows
        self.style = style
        self.rowStyle = rowStyle
    }

    // MARK: - Body
    public var body: some View {
        if !rows.isEmpty {
            VStack(alignment: .leading, spacing: style.headerSpacing) {
                if let header {
                    Text(header)
                        .font(style.headerFont)
                        .textCase(style.headerTextCase)
                        .foregroundStyle(style.headerColor)
                        .padding(.horizontal, style.headerInset)
                        .accessibilityAddTraits(.isHeader)
                }
                Card(style: style.cardStyle) {
                    VStack(spacing: 0) {
                        ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                            if index > 0 {
                                DividerAtom(style: dividerStyle)
                            }
                            row
                        }
                    }
                }
            }
        }
    }

    private var dividerStyle: DividerStyle {
        guard style.alignsDividersWithText else { return style.dividerStyle }
        return DividerStyle(
            color: style.dividerStyle.color,
            thickness: style.dividerStyle.thickness,
            leadingInset: rowStyle.textInset,
            trailingInset: style.dividerStyle.trailingInset
        )
    }
}

#if DEBUG
#Preview("SettingsGroup — two groups") {
    VStack(spacing: 32) {
        SettingsGroup(header: .verbatim("Preferences"), rows: [
            SettingsRow(id: "dietary", systemImage: "leaf", title: .verbatim("Allergies and intolerances")) {
                Text(verbatim: "2").foregroundStyle(.secondary)
            } action: {},
            SettingsRow(
                id: "alerts", systemImage: "bell", title: .verbatim("Reminders"),
                subtitle: .verbatim("A nudge before your events, and when guests answer")
            ) {
                Text(verbatim: "On").foregroundStyle(.green)
            } action: {},
        ])
        SettingsGroup(header: .verbatim("App"), rows: [
            SettingsRow(id: "privacy", systemImage: "lock.shield", title: .verbatim("Your data and privacy")) {},
        ])
        SettingsGroup(header: .verbatim("Nothing here"), rows: [])
    }
    .padding()
}

#Preview("SettingsGroup — full-width dividers") {
    SettingsGroup(
        header: .verbatim("Account"),
        rows: [
            SettingsRow(id: "name", systemImage: "person", title: .verbatim("Name")) {},
            SettingsRow(id: "mail", systemImage: "envelope", title: .verbatim("Email")) {},
        ],
        style: .fullWidthDividers
    )
    .padding()
}
#endif
