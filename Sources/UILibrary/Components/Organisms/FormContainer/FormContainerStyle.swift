import SwiftUI

/// Style contract for FormContainer organism
///
/// Named `FormContainerStyle` (not `FormStyle`) to avoid ambiguity with the
/// `SwiftUI.FormStyle` protocol.
public struct FormContainerStyle: Equatable, Sendable {
    public let sectionSpacing: CGFloat
    public let padding: EdgeInsets
    public let backgroundColor: Color?

    public init(
        sectionSpacing: CGFloat,
        padding: EdgeInsets,
        backgroundColor: Color? = nil
    ) {
        self.sectionSpacing = sectionSpacing
        self.padding = padding
        self.backgroundColor = backgroundColor
    }
}
