//
//  Popup.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

import SwiftUI

/// Popup view used to show a short message with an icon.
///
/// **Layer:** Organism
///
/// **Responsibility:**
/// Purely presentational popup with an icon and a short message. All visual tokens are provided via `PopupStyle`.
///
/// **Usage:**
/// Inject a `PopupStyle` to control colors and appearance.
///
/// Example:
/// ```swift
/// let style = PopupStyle.neutral
/// Popup(icon: "info.circle", message: "Saved!", style: style)
/// ```
public struct Popup: View {
    
    private let icon: String
    private let message: String
    private let style: PopupStyle

    /// Creates a `Popup`.
    /// - Parameters:
    ///   - icon: `String` system image name displayed on the leading edge.
    ///   - message: Text message to display.
    ///   - style: Visual style to apply (default: `.neutral`).
    public init(
        icon: String,
        message: String,
        style: PopupStyle = .neutral
    ) {
        self.icon = icon
        self.message = message
        self.style = style
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(style.iconColor)
                .frame(width: 24, height: 24)
            
            Text(message)
                .foregroundStyle(style.textColor)
                .font(.system(size: 16))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(style.backgroundColor)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    Popup(
        icon: "exclamationmark.circle",
        message: "See an issue? File an issue on GitHub",
        style: .neutral
    )
    
    Popup(
        icon: "checkmark.circle",
        message: "Your changes have been saved.",
        style: .success
    )
    
    Popup(
        icon: "wifi.slash",
        message: "You are offline. Check your connection and try again.",
        style: .warning
    )
    
    Popup(
        icon: "exclamationmark",
        message: "An error occurred. Please try again later.",
        style: .error
    )
}
