import SwiftUI

public extension CardStyle {
    /// Neutral/default card (translucent material surface, subtle shadow).
    static let neutral = CardStyle(material: .ultraThin)

    /// Surface variant — useful when card needs a filled surface.
    static let surface = CardStyle(backgroundColor: .gray.opacity(0.1))
}
