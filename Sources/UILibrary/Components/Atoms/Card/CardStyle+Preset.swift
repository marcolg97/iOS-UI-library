import SwiftUI

public extension CardStyle {
    /// Neutral/default card (no solid background, subtle shadow).
    static let neutral = CardStyle()

    /// Surface variant — useful when card needs a filled surface.
    static let surface = CardStyle(backgroundColor: .gray.opacity(0.1))
}
