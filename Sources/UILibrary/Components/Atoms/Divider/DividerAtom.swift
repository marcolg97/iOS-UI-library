//
//  DividerAtom.swift
//  UILibrary
//

import SwiftUI

/// Divider Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected separator line supporting
/// both axes, custom thickness, color, and insets.
///
/// ## Usage
/// ```swift
/// DividerAtom()                       // horizontal hairline
/// DividerAtom(axis: .vertical)       // vertical separator
/// DividerAtom(style: .inset)         // list-style leading inset
/// ```
public struct DividerAtom: View {
    /// Orientation of the divider.
    public enum Axis: Equatable, Sendable {
        case horizontal
        case vertical
    }

    private let axis: Axis
    private let style: DividerStyle

    public init(axis: Axis = .horizontal, style: DividerStyle = .default) {
        self.axis = axis
        self.style = style
    }

    public var body: some View {
        Rectangle()
            .fill(style.color)
            .frame(
                width: axis == .vertical ? style.thickness : nil,
                height: axis == .horizontal ? style.thickness : nil
            )
            .padding(
                axis == .horizontal ? .leading : .top,
                style.leadingInset
            )
            .padding(
                axis == .horizontal ? .trailing : .bottom,
                style.trailingInset
            )
            .accessibilityHidden(true)
    }
}

#if DEBUG
#Preview("Dividers") {
    VStack(spacing: 24) {
        Text(verbatim: "Above the divider")
        DividerAtom()
        Text(verbatim: "Between dividers")
        DividerAtom(style: .inset)
        DividerAtom(style: .init(color: .accentColor, thickness: 2))

        HStack(spacing: 16) {
            Text(verbatim: "Left")
            DividerAtom(axis: .vertical)
            Text(verbatim: "Right")
        }
        .frame(height: 40)
    }
    .padding()
}
#endif
