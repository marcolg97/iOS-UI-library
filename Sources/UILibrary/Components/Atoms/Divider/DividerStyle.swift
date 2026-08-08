//
//  DividerStyle.swift
//  UILibrary
//

import SwiftUI

/// Style contract for `DividerAtom`.
public struct DividerStyle: Equatable, Sendable {
    /// Line color.
    public let color: Color
    /// Line thickness in points.
    public let thickness: CGFloat
    /// Inset at the leading (horizontal axis) or top (vertical axis) edge.
    public let leadingInset: CGFloat
    /// Inset at the trailing (horizontal axis) or bottom (vertical axis) edge.
    public let trailingInset: CGFloat

    public init(
        color: Color = Color.primary.opacity(0.12),
        thickness: CGFloat = 1,
        leadingInset: CGFloat = 0,
        trailingInset: CGFloat = 0
    ) {
        self.color = color
        self.thickness = thickness
        self.leadingInset = leadingInset
        self.trailingInset = trailingInset
    }
}
