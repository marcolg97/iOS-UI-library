//
//  IfModifier.swift
//  CoreUI
//
//  Created by Marco La Gala on 30/01/26.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
