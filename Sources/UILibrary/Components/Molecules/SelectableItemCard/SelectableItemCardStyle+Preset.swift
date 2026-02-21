import SwiftUI

public extension SelectableItemCardStyle {
    static let `default`: SelectableItemCardStyle = .init(
        selectedIconBackgroundColor: .cyan.opacity(0.2),
        unselectedIconBackgroundColor: .white.opacity(0.05),
        selectedIconColor: .cyan,
        unselectedIconColor: .white.opacity(0.8),
        selectedTitleColor: .cyan,
        unselectedTitleColor: .primary,
        subtitleColor: .primary.opacity(0.6),
        selectedIndicatorColor: .cyan,
        unselectedIndicatorColor: .primary.opacity(0.2),
        selectedBackgroundColor: .cyan.opacity(0.1),
        unselectedBackgroundColor: .primary.opacity(0.05),
        selectedBorderColor: .cyan.opacity(0.5),
        unselectedBorderColor: .primary.opacity(0.05)
    )
}
