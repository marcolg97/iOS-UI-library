//
//  View+ReadHeight.swift
//  UILibrary
//
//  Moved from Modifiers/ to Extensions/ to follow project structure rules.
//

import SwiftUI

/// Reads and reports the height of a view whenever it changes.
///
/// This modifier uses `GeometryReader` and preference keys to measure the view's height
/// and reports changes through a callback. Useful for coordinating layouts, animations,
/// or scroll behaviors that depend on dynamic content height.
///
/// - Parameter onChange: Callback invoked on the main actor when the height changes.
///   Receives the new height value in points.
public extension View {
    func readHeight(_ onChange: @escaping @MainActor @Sendable (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
            }
        )
        .onPreferenceChange(HeightPreferenceKey.self, perform: onChange)
    }
}

// Preference key used by `readHeight`.
private struct HeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
