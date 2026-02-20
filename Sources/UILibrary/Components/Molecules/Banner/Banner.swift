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
    private let title: String
    
    /// Optional secondary message.
    private let subtitle: String?
    
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
        title: String,
        subtitle: String? = nil,
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
            Image(systemName: style.customIcon ?? "")
                .font(.system(size: style.iconSize))
                .foregroundStyle(style.iconColor)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: style.verticalSpacing) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(style.titleColor)
                    .multilineTextAlignment(.leading)
                    .accessibilityAddTraits(.isHeader)

                if let subtitle {
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(style.subtitleColor)
                        .multilineTextAlignment(.leading)
                }

                actionContent()
                    .font(.footnote.weight(.semibold))
                    .buttonStyle(.plain)
                    .foregroundStyle(style.actionColor)
                    .padding(.top, 4)
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
        title: String,
        subtitle: String? = nil,
        style: BannerStyle = .info()
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.actionContent = { EmptyView() }
    }
}

#Preview("Styles") {
    VStack(spacing: 16) {
        Banner(
            title: "Missing your language?",
            subtitle: "Email us and we'll try to add it as soon as possible.",
            style: .info(),
            actionContent: {
                Button(action: {}) {
                    Label("Email us", systemImage: "arrow.up.right")
                }
            }
        )
        
        Banner(
            title: "Warning",
            subtitle: "This action cannot be undone.",
            style: .warning()
        )
        
        Banner(
            title: "Success!",
            subtitle: "Your changes have been saved.",
            style: .success()
        )
        
        Banner(
            title: "Error",
            subtitle: "Something went wrong.",
            style: .error()
        )
    }
    .padding()
}

#Preview("3D Styles") {
    VStack(spacing: 16) {
        Banner(
            title: "App Update Available",
            subtitle: "Version 2.0 is now available with new features.",
            style: .threeDimensionalInfo(),
            actionContent: {
                Button(action: {}) {
                    Label("Update Now", systemImage: "arrow.down.circle")
                }
            }
        )
        
        Banner(
            title: "Storage Almost Full",
            subtitle: "You're using 95% of your available storage.",
            style: .threeDimensionalWarning()
        )
        
        Banner(
            title: "Backup Complete",
            subtitle: "Your data has been safely backed up.",
            style: .threeDimensionalSuccess()
        )
        
        Banner(
            title: "Connection Lost",
            subtitle: "Unable to connect to the server.",
            style: .threeDimensionalError()
        )
    }
    .padding()
}
