import SwiftUI

public extension SelectableItemCardStyle {
    static let `default`: SelectableItemCardStyle = .init(
        selectedIndicatorColor: .accentColor,
        unselectedIndicatorColor: .primary.opacity(0.2),
        selectedBackgroundColor: .accentColor.opacity(0.1),
        unselectedBackgroundColor: .primary.opacity(0.05),
        selectedBorderColor: .accentColor.opacity(0.5),
        unselectedBorderColor: .primary.opacity(0.05)
    )
}
