import SwiftUI

public extension AvatarImageStyle {
    /// Default style (40×40 circle with light gray background).
    static let `default` = AvatarImageStyle()

    /// Smaller variation useful for list rows or compact layouts.
    static let small = AvatarImageStyle(size: 28, font: .subheadline)

    /// Large variation suitable for profile screens.
    static let large = AvatarImageStyle(size: 64, font: .title)

    /// Bordered variant often used to indicate selection state.
    static func bordered(_ color: Color = .accentColor) -> AvatarImageStyle {
        AvatarImageStyle(borderColor: color, borderWidth: 2)
    }
}
