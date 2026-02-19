import SwiftUI

public extension GhostButtonStyle {
    /// Neutral/link style — uses `accentColor` for interactive emphasis.
    static let neutral = GhostButtonStyle()

    /// Emphasized style — stronger visual emphasis (useful for primary inline actions).
    static let emphasized = GhostButtonStyle(textColor: .white, iconColor: .white, font: .body, underline: false)
}
