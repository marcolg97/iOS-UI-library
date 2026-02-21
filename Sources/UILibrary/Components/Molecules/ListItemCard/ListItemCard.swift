//
//  ListItemCard.swift
//  UILibrary
//
//  Created by Marco La Gala on 21/02/26.
//

import SwiftUI

/// Reusable list row card made of leading, content, and trailing slots.
///
/// Built on top of `Card` to keep a consistent base surface across components.
/// Reusable list row card with leading/content/trailing slots.
/// Use it to standardize the surface, spacing, and press feedback of action rows.
public struct ListItemCard<Leading: View, Content: View, Trailing: View>: View {
    private let style: ListItemCardStyle
    private let action: () -> Void
    @ViewBuilder private let leading: () -> Leading
    @ViewBuilder private let content: () -> Content
    @ViewBuilder private let trailing: () -> Trailing

    public init(
        style: ListItemCardStyle = .default,
        action: @escaping () -> Void,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.style = style
        self.action = action
        self.leading = leading
        self.content = content
        self.trailing = trailing
    }

    public var body: some View {
        Button(action: action) {
            Card(style: style.cardStyle) {
                HStack(spacing: style.contentSpacing) {
                    leading()
                    content()
                    Spacer(minLength: 0)
                    trailing()
                }
            }
        }
        .buttonStyle(PressScaleButtonStyle(pressedScale: style.pressedScale))
    }
}

private struct PressScaleButtonStyle: ButtonStyle {
    let pressedScale: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

#Preview {
    ListItemCard(style: .default, action: {}) {
        Image(systemName: "book.fill")
            .font(.title2)
            .foregroundStyle(.cyan)
    } content: {
        VStack(alignment: .leading, spacing: 4) {
            Text("Course title")
                .font(.headline)
                .foregroundStyle(.primary)
            Text("Subtitle")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.7))
        }
    } trailing: {
        Image(systemName: "chevron.right")
            .foregroundStyle(.primary.opacity(0.4))
    }
    .padding()
}
