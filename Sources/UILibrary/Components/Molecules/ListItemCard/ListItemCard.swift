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

/// Convenience initializers for rows without leading or trailing slots.
public extension ListItemCard where Leading == EmptyView {
    init(
        style: ListItemCardStyle = .default,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.init(style: style, action: action, leading: { EmptyView() }, content: content, trailing: trailing)
    }
}

public extension ListItemCard where Leading == EmptyView, Trailing == EmptyView {
    init(
        style: ListItemCardStyle = .default,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(style: style, action: action, leading: { EmptyView() }, content: content, trailing: { EmptyView() })
    }
}

private struct PressScaleButtonStyle: ButtonStyle {
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
