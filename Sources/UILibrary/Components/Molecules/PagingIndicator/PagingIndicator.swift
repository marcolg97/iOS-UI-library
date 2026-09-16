//
//  PagingIndicator.swift
//  UILibrary
//

import SwiftUI

/// A capsule page indicator whose active segment stretches continuously with `progress`.
///
/// Unlike `TabView(.page)`'s dots — and unlike `CarouselView`'s own paging dots — this reads a
/// continuous `0...pageCount - 1` value rather than a discrete selection, so it tracks a
/// `ScrollView` + `.scrollTargetBehavior(.paging)` pager *mid-drag* instead of jumping when the
/// page finally snaps.
///
/// The view is stateless and does not animate itself, which keeps it deterministic under snapshot
/// testing. A caller that wants a settle spring on release applies `.animation(_:value:)` around
/// it, and is responsible for gating that behind Reduce Motion.
public struct PagingIndicator: View {
    private let progress: Double
    private let pageCount: Int
    private let style: PagingIndicatorStyle

    public init(progress: Double, pageCount: Int, style: PagingIndicatorStyle = PagingIndicatorStyle()) {
        self.progress = progress
        self.pageCount = pageCount
        self.style = style
    }

    public var body: some View {
        HStack(spacing: style.spacing) {
            ForEach(0..<pageCount, id: \.self) { index in
                // 1 when `index` is fully focused, fading to 0 as an adjacent page takes over.
                let proximity = max(0, 1 - abs(progress - Double(index)))
                Capsule()
                    .fill(proximity > 0.001 ? style.activeColor : style.inactiveColor)
                    .frame(
                        width: style.dotSize + (style.activeWidth - style.dotSize) * proximity,
                        height: style.dotSize
                    )
            }
        }
        .accessibilityHidden(true)
    }
}

/// Style contract for `PagingIndicator`.
public struct PagingIndicatorStyle: Equatable, Sendable {
    public let dotSize: CGFloat
    public let activeWidth: CGFloat
    public let spacing: CGFloat
    public let activeColor: Color
    public let inactiveColor: Color

    public init(
        dotSize: CGFloat = 8,
        activeWidth: CGFloat = 24,
        spacing: CGFloat = 8,
        activeColor: Color = .accentColor,
        inactiveColor: Color = Color.primary.opacity(0.15)
    ) {
        self.dotSize = dotSize
        self.activeWidth = activeWidth
        self.spacing = spacing
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
}

#Preview("Paging indicator") {
    VStack(spacing: 24) {
        ForEach([0.0, 0.35, 1.0, 1.7, 2.0], id: \.self) { progress in
            PagingIndicator(progress: progress, pageCount: 3)
        }
    }
    .padding()
}
