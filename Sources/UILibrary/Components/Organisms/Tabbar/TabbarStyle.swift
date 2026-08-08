//
//  TabbarStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `TabbarView`.
///
/// The system tab bar owns most of its appearance; this style exposes the
/// tokens SwiftUI allows a library to control.
public struct TabbarStyle: Equatable, Sendable {
    /// Tint applied to the tab bar items (nil = inherit the app accent color).
    public let tint: Color?

    /// Creates a `TabbarStyle`.
    /// - Parameter tint: Tint for tab items (default: nil, inherits accent).
    public init(tint: Color? = nil) {
        self.tint = tint
    }
}
