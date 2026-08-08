//
//  LockScreenViewStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Style contract for `LockScreenView`.
///
/// Describes visual tokens for background, text, icon, and button appearance.
public struct LockScreenViewStyle: Equatable, Sendable {
    /// When `true`, an opaque `.regularMaterial` layer is drawn behind
    /// `backgroundColor`, hiding the app content while locked.
    public let usesMaterialBackground: Bool
    public let backgroundColor: Color
    public let iconColor: Color
    public let titleColor: Color
    public let subtitleColor: Color
    public let buttonBackgroundColor: Color
    public let buttonForegroundColor: Color
    public let titleFont: Font
    public let subtitleFont: Font
    public let buttonFont: Font
    public let iconSize: CGFloat
    public let verticalSpacing: CGFloat
    public let textSpacing: CGFloat
    public let horizontalPadding: CGFloat
    public let bottomPadding: CGFloat
    public let buttonCornerRadius: CGFloat

    public init(
        backgroundColor: Color,
        iconColor: Color,
        titleColor: Color,
        subtitleColor: Color,
        buttonBackgroundColor: Color,
        buttonForegroundColor: Color,
        usesMaterialBackground: Bool = true,
        titleFont: Font = .title2.weight(.semibold),
        subtitleFont: Font = .body,
        buttonFont: Font = .body.weight(.semibold),
        iconSize: CGFloat = 80,
        verticalSpacing: CGFloat = 32,
        textSpacing: CGFloat = 12,
        horizontalPadding: CGFloat = 40,
        bottomPadding: CGFloat = 60,
        buttonCornerRadius: CGFloat = 16
    ) {
        self.usesMaterialBackground = usesMaterialBackground
        self.backgroundColor = backgroundColor
        self.iconColor = iconColor
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonForegroundColor = buttonForegroundColor
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.buttonFont = buttonFont
        self.iconSize = iconSize
        self.verticalSpacing = verticalSpacing
        self.textSpacing = textSpacing
        self.horizontalPadding = horizontalPadding
        self.bottomPadding = bottomPadding
        self.buttonCornerRadius = buttonCornerRadius
    }
}
