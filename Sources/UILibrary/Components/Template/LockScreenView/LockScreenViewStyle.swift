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
        titleFont: Font = .title2.weight(.semibold),
        subtitleFont: Font = .body,
        buttonFont: Font = .body.weight(.semibold),
        iconSize: CGFloat = 80,
        verticalSpacing: CGFloat = 32,
        horizontalPadding: CGFloat = 40,
        bottomPadding: CGFloat = 60,
        buttonCornerRadius: CGFloat = 16
    ) {
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
        self.horizontalPadding = horizontalPadding
        self.bottomPadding = bottomPadding
        self.buttonCornerRadius = buttonCornerRadius
    }
}
