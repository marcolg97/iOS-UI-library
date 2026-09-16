//
//  GoogleSignInButtonStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `GoogleSignInButton`.
///
/// The defaults are Google's own published values for the light and dark button, so a consumer
/// that passes nothing is already compliant. Shape and height are deliberately left to the
/// consumer's `ActionButtonStyle`, because the whole reason this component exists instead of
/// Google's SDK button is that the SDK hardcodes a 2pt radius and a 40pt height, which cannot be
/// made to match an app whose other buttons are pills.
public struct GoogleSignInButtonStyle: Equatable, Sendable {
    public let surfaceColor: Color
    public let borderColor: Color
    public let textColor: Color
    /// Google's guidelines fix the logo's size relative to the label; 18pt pairs with a body-sized
    /// title. Changing it is allowed, removing or recolouring the logo is not.
    public let logoSize: CGFloat
    public let spacing: CGFloat

    public init(
        surfaceColor: Color = Color(red: 1, green: 1, blue: 1),
        borderColor: Color = Color(red: 0.455, green: 0.463, blue: 0.459),
        textColor: Color = Color(red: 0.122, green: 0.122, blue: 0.122),
        logoSize: CGFloat = 18,
        spacing: CGFloat = 8
    ) {
        self.surfaceColor = surfaceColor
        self.borderColor = borderColor
        self.textColor = textColor
        self.logoSize = logoSize
        self.spacing = spacing
    }

    /// Google's published light-theme button colours.
    public static let light = GoogleSignInButtonStyle()

    /// Google's published dark-theme button colours.
    public static let dark = GoogleSignInButtonStyle(
        surfaceColor: Color(red: 0.075, green: 0.075, blue: 0.078),
        borderColor: Color(red: 0.557, green: 0.569, blue: 0.561),
        textColor: Color(red: 0.890, green: 0.890, blue: 0.890)
    )

    /// Picks the variant matching the environment's colour scheme.
    public static func matching(_ colorScheme: ColorScheme) -> GoogleSignInButtonStyle {
        colorScheme == .dark ? .dark : .light
    }
}
