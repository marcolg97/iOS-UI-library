//
//  Banner.swift
//  UILibrary
//
//  Created by Marco La Gala on 20/02/26.
//

import SwiftUI

/// A contextual banner for displaying informational messages with optional actions.
///
/// **Layer:** Molecule
///
/// **Responsibility:**
/// Purely presentational banner with icon, title, optional subtitle, and optional action content.
/// All visual tokens are provided via `BannerStyle`.
///
/// **Usage:**
/// Inject a `BannerStyle` to control colors, spacing, and appearance.
///
/// Example:
/// ```swift
/// // Simple banner
/// Banner(
///     title: "Success!",
///     subtitle: "Your changes have been saved.",
///     style: .success()
/// )
///
/// // Banner with action
/// Banner(
///     title: "Missing your language?",
///     subtitle: "Email us and we'll try to add it as soon as possible.",
///     style: .info(),
///     actionContent: {
///         Button("Email us") { openEmail() }
///     }
/// )
/// ```
public struct Banner<ActionContent: View>: View {
    /// The main banner message.
    private let title: LocalizedStringResource

    /// Optional secondary message.
    private let subtitle: LocalizedStringResource?

    /// Visual style of the banner.
    private let style: BannerStyle

    /// Optional custom action view displayed at the bottom.
    @ViewBuilder private let actionContent: () -> ActionContent

    /// Creates a banner with custom action content.
    ///
    /// - Parameters:
    ///   - title: The main banner message.
    ///   - subtitle: Optional secondary message.
    ///   - style: Visual style (default: `.info()`).
    ///   - actionContent: ViewBuilder for custom action content.
    public init(
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource? = nil,
        style: BannerStyle = .info(),
        @ViewBuilder actionContent: @escaping () -> ActionContent
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.actionContent = actionContent
    }

    public var body: some View {
        HStack(alignment: .top, spacing: style.spacing) {
            if let icon = style.customIcon {
                Image(systemName: icon)
                    .font(.system(size: style.iconSize))
                    .foregroundStyle(style.iconColor)
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: style.verticalSpacing) {
                VStack(alignment: .leading, spacing: style.verticalSpacing) {
                    Text(title)
                        .font(style.titleFont)
                        .foregroundStyle(style.titleColor)
                        .multilineTextAlignment(.leading)

                    if let subtitle {
                        Text(subtitle)
                            .font(style.subtitleFont)
                            .foregroundStyle(style.subtitleColor)
                            .multilineTextAlignment(.leading)
                    }
                }
                .accessibilityElement(children: .combine)

                if ActionContent.self != EmptyView.self {
                    actionContent()
                        .font(style.actionFont)
                        .foregroundStyle(style.actionColor)
                        .padding(.top, 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(style.padding)
        .background(style.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
        .shadow(
            color: style.shadowColor ?? .clear,
            radius: style.shadowRadius,
            x: style.shadowOffset.width,
            y: style.shadowOffset.height
        )
    }
}

/// Convenience initializer for banners without custom action content.
public extension Banner where ActionContent == EmptyView {
    /// Creates a banner without custom action content.
    ///
    /// - Parameters:
    ///   - title: The main banner message.
    ///   - subtitle: Optional secondary message.
    ///   - style: Visual style (default: `.info()`).
    init(
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource? = nil,
        style: BannerStyle = .info()
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.actionContent = { EmptyView() }
    }
}

#if DEBUG
#Preview("Styles") {
    VStack(spacing: 16) {
        Banner(
            title: .verbatim("Missing your language?"),
            subtitle: .verbatim("Email us and we'll try to add it as soon as possible."),
            style: .info(),
            actionContent: {
                Button(action: {}) {
                    Label {
                        Text(verbatim: "Email us")
                    } icon: {
                        Image(systemName: "arrow.up.right")
                    }
                }
            }
        )

        Banner(
            title: .verbatim("Warning"),
            subtitle: .verbatim("This action cannot be undone."),
            style: .warning()
        )

        Banner(
            title: .verbatim("Success!"),
            subtitle: .verbatim("Your changes have been saved."),
            style: .success()
        )

        Banner(
            title: .verbatim("Error"),
            subtitle: .verbatim("Something went wrong."),
            style: .error()
        )
    }
    .padding()
}

#Preview("3D Styles") {
    VStack(spacing: 16) {
        Banner(
            title: .verbatim("App Update Available"),
            subtitle: .verbatim("Version 2.0 is now available with new features."),
            style: .threeDimensionalInfo(),
            actionContent: {
                Button(action: {}) {
                    Label {
                        Text(verbatim: "Update Now")
                    } icon: {
                        Image(systemName: "arrow.down.circle")
                    }
                }
            }
        )

        Banner(
            title: .verbatim("Storage Almost Full"),
            subtitle: .verbatim("You're using 95% of your available storage."),
            style: .threeDimensionalWarning()
        )

        Banner(
            title: .verbatim("Backup Complete"),
            subtitle: .verbatim("Your data has been safely backed up."),
            style: .threeDimensionalSuccess()
        )

        Banner(
            title: .verbatim("Connection Lost"),
            subtitle: .verbatim("Unable to connect to the server."),
            style: .threeDimensionalError()
        )
    }
    .padding()
}
#endif
