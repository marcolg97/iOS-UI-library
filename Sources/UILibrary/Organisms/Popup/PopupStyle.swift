//
//  PopupStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

import SwiftUI

/// Style contract for `Popup`.
///
/// Describes visual tokens used by `Popup` (icon/text/background colors). Immutable and brand-agnostic.
public struct PopupStyle: Equatable, Sendable {
    /// Color used for the icon.
    public let iconColor: Color
    /// Color used for the message text.
    public let textColor: Color
    /// Background color for the popup surface.
    public let backgroundColor: Color
    
    /// Creates a `PopupStyle`.
    /// - Parameters:
    ///   - iconColor: Color for the icon.
    ///   - textColor: Color for the text.
    ///   - backgroundColor: Background color for the popup.
    public init(
        iconColor: Color,
        textColor: Color,
        backgroundColor: Color
    ) {
        self.iconColor = iconColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
