//
//  BannerStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 20/02/26.
//

import SwiftUI

/// Style contract for `Banner`.
///
/// Describes visual tokens used by `Banner` (background, icon, text colors, layout metrics).
/// Immutable and brand-agnostic.
public struct BannerStyle: Equatable, Sendable {
    /// Background color of the banner.
    public let backgroundColor: Color
    
    /// Color used for the icon.
    public let iconColor: Color
    
    /// Color used for the title text.
    public let titleColor: Color
    
    /// Color used for the subtitle text.
    public let subtitleColor: Color
    
    /// Color used for action content (e.g., buttons, links).
    public let actionColor: Color
    
    /// Optional custom icon (SF Symbol name). If nil, uses default for semantic type.
    public let customIcon: String?
    
    /// Corner radius for the banner container.
    public let cornerRadius: CGFloat
    
    /// Internal padding around banner content.
    public let padding: CGFloat
    
    /// Size of the icon.
    public let iconSize: CGFloat
    
    /// Horizontal spacing between icon and content.
    public let spacing: CGFloat
    
    /// Vertical spacing between title and subtitle.
    public let verticalSpacing: CGFloat
    
    /// Creates a `BannerStyle`.
    /// - Parameters:
    ///   - backgroundColor: Background color of the banner.
    ///   - iconColor: Color for the icon.
    ///   - titleColor: Color for the title text.
    ///   - subtitleColor: Color for the subtitle text.
    ///   - actionColor: Color for action content.
    ///   - customIcon: Optional custom icon (SF Symbol name).
    ///   - cornerRadius: Corner radius for the banner container (default: 12).
    ///   - padding: Internal padding around content (default: 16).
    ///   - iconSize: Size of the icon (default: 20).
    ///   - spacing: Horizontal spacing between icon and content (default: 12).
    ///   - verticalSpacing: Vertical spacing between title and subtitle (default: 4).
    public init(
        backgroundColor: Color,
        iconColor: Color,
        titleColor: Color,
        subtitleColor: Color,
        actionColor: Color,
        customIcon: String? = nil,
        cornerRadius: CGFloat = 12,
        padding: CGFloat = 16,
        iconSize: CGFloat = 20,
        spacing: CGFloat = 12,
        verticalSpacing: CGFloat = 4
    ) {
        self.backgroundColor = backgroundColor
        self.iconColor = iconColor
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.actionColor = actionColor
        self.customIcon = customIcon
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.iconSize = iconSize
        self.spacing = spacing
        self.verticalSpacing = verticalSpacing
    }
}
