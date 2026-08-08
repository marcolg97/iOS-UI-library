//
//  IfModifier.swift
//  UILibrary
//
//  Created by Marco La Gala on 30/01/26.
//

import SwiftUI

public extension View {
    /// Conditionally applies a transform to the view.
    ///
    /// - Warning: The two branches produce different view types, so SwiftUI
    ///   treats them as different views: when `condition` changes at runtime
    ///   the subtree is rebuilt and loses state/animations. Prefer passing the
    ///   condition *into* a single modifier when it can change dynamically;
    ///   reserve `if` for conditions fixed for the lifetime of the view.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
