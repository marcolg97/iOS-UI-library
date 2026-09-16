//
//  View+OptionalAccessibilityIdentifier.swift
//  UILibrary
//

import SwiftUI

public extension View {
    /// Applies an accessibility identifier only when one is supplied.
    ///
    /// Components take their identifier from the consumer, which often has none to give — applying
    /// `.accessibilityIdentifier("")` in that case would still stamp an (empty) identifier onto the
    /// element and shadow one set further up the hierarchy.
    @ViewBuilder
    func optionalAccessibilityIdentifier(_ identifier: String?) -> some View {
        if let identifier {
            accessibilityIdentifier(identifier)
        } else {
            self
        }
    }
}
