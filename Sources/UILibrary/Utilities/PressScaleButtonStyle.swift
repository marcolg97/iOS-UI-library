//
//  PressScaleButtonStyle.swift
//  UILibrary
//

import SwiftUI

/// The shared press feedback for row-shaped buttons: a slight scale-down while held.
///
/// Used by `ListItemCard` and `SettingsRow` so a row feels the same wherever it appears. Honours
/// Reduce Motion by skipping both the scale and the animation.
struct PressScaleButtonStyle: ButtonStyle {
    let pressedScale: CGFloat

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? pressedScale : 1.0)
            .animation(
                reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.7),
                value: configuration.isPressed
            )
    }
}

#if DEBUG
#Preview {
    ListItemCard(style: .default, action: {}) {
        Image(systemName: "book.fill")
            .font(.title2)
            .foregroundStyle(.tint)
    } content: {
        VStack(alignment: .leading, spacing: 4) {
            Text(verbatim: "Item title")
                .font(.headline)
                .foregroundStyle(.primary)
            Text(verbatim: "Subtitle")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.7))
        }
    } trailing: {
        Image(systemName: "chevron.right")
            .foregroundStyle(.primary.opacity(0.4))
    }
    .padding()
}
#endif
