//
//  SkeletonView.swift
//  UILibrary
//

import SwiftUI

/// Skeleton Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic shimmering placeholder shown while content
/// loads. When Reduce Motion is enabled the shimmer is replaced by a static
/// tint.
///
/// ## Usage
/// ```swift
/// // Standalone placeholder block
/// SkeletonView()
///     .frame(width: 200, height: 16)
///
/// // Skeleton over existing content
/// ProfileRow(user: user)
///     .skeleton(isLoading: isLoading)
/// ```
public struct SkeletonView: View {
    private let style: SkeletonStyle

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(style: SkeletonStyle = .default) {
        self.style = style
    }

    public var body: some View {
        shape
            .fill(style.baseColor)
            .overlay {
                if reduceMotion {
                    shape.fill(style.highlightColor.opacity(0.5))
                } else {
                    TimelineView(.animation) { context in
                        let duration = max(0.1, style.shimmerDuration)
                        let elapsed = context.date.timeIntervalSinceReferenceDate
                        let phase = elapsed.truncatingRemainder(dividingBy: duration) / duration

                        shape.fill(
                            LinearGradient(
                                stops: [
                                    .init(color: .clear, location: 0),
                                    .init(color: style.highlightColor, location: 0.5),
                                    .init(color: .clear, location: 1)
                                ],
                                startPoint: UnitPoint(x: phase * 3 - 2, y: 0.5),
                                endPoint: UnitPoint(x: phase * 3 - 1, y: 0.5)
                            )
                        )
                    }
                }
            }
            .clipShape(shape)
            .accessibilityHidden(true)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
    }
}

// MARK: - Skeleton modifier

private struct SkeletonModifier: ViewModifier {
    let isLoading: Bool
    let style: SkeletonStyle

    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .overlay {
                if isLoading {
                    SkeletonView(style: style)
                }
            }
            .accessibilityElement(children: isLoading ? .ignore : .contain)
            .accessibilityLabel(isLoading ? Text("Loading", bundle: .module) : Text(verbatim: ""))
    }
}

public extension View {
    /// Replaces this view with a shimmering skeleton of the same size while
    /// `isLoading` is `true`.
    ///
    /// - Parameters:
    ///   - isLoading: Whether the skeleton is shown instead of the content.
    ///   - style: Visual tokens for the skeleton (default: `.default`).
    func skeleton(isLoading: Bool, style: SkeletonStyle = .default) -> some View {
        modifier(SkeletonModifier(isLoading: isLoading, style: style))
    }
}

#if DEBUG
#Preview("Skeleton") {
    @Previewable @State var isLoading = true

    VStack(alignment: .leading, spacing: 16) {
        SkeletonView()
            .frame(width: 220, height: 16)
        SkeletonView()
            .frame(width: 160, height: 16)
        SkeletonView(style: .init(cornerRadius: 22))
            .frame(width: 44, height: 44)

        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(verbatim: "Row title")
                Text(verbatim: "Row subtitle")
                    .font(.caption)
            }
        }
        .skeleton(isLoading: isLoading)

        Button(action: { isLoading.toggle() }) {
            Text(verbatim: "Toggle loading")
        }
    }
    .padding()
}
#endif
