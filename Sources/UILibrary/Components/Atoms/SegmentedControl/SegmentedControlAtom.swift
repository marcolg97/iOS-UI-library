//
//  SegmentedControlAtom.swift
//  UILibrary
//

import SwiftUI

/// SegmentedControl Atom
///
/// Layer: Atom
/// Responsibility: Brand-agnostic, style-injected segmented picker with a
/// sliding selection indicator.
///
/// ## Usage
/// ```swift
/// enum Range: CaseIterable { case week, month, year }
///
/// SegmentedControlAtom(
///     selection: $range,
///     options: Range.allCases,
///     title: { LocalizedStringResource(stringLiteral: "\($0)") }
/// )
/// ```
public struct SegmentedControlAtom<Option: Hashable>: View {
    @Binding private var selection: Option
    private let options: [Option]
    private let title: (Option) -> LocalizedStringResource
    private let style: SegmentedControlStyle

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var indicatorNamespace

    /// Creates a `SegmentedControlAtom`.
    /// - Parameters:
    ///   - selection: Binding to the selected option.
    ///   - options: Options rendered as segments, in order.
    ///   - title: Localized title for each option.
    ///   - style: Visual tokens (default: `.default`).
    public init(
        selection: Binding<Option>,
        options: [Option],
        title: @escaping (Option) -> LocalizedStringResource,
        style: SegmentedControlStyle = .default
    ) {
        self._selection = selection
        self.options = options
        self.title = title
        self.style = style
    }

    public var body: some View {
        HStack(spacing: style.segmentSpacing) {
            ForEach(options, id: \.self) { option in
                segment(for: option)
            }
        }
        .padding(style.containerPadding)
        .background(
            RoundedRectangle(cornerRadius: style.containerCornerRadius, style: .continuous)
                .fill(style.containerBackgroundColor)
        )
        .frame(minHeight: style.minTapTarget)
        .animation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.8), value: selection)
    }

    private func segment(for option: Option) -> some View {
        let isSelected = option == selection
        return Button {
            selection = option
        } label: {
            Text(title(option))
                .font(isSelected ? style.selectedFont : style.font)
                .foregroundStyle(isSelected ? style.selectedTextColor : style.textColor)
                .lineLimit(1)
                .padding(.vertical, style.segmentVerticalPadding)
                .padding(.horizontal, style.segmentHorizontalPadding)
                .frame(maxWidth: .infinity)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: style.segmentCornerRadius, style: .continuous)
                            .fill(style.selectedBackgroundColor)
                            .matchedGeometryEffect(id: "indicator", in: indicatorNamespace)
                    }
                }
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
    }
}

#if DEBUG
private enum PreviewRange: String, CaseIterable {
    case week, month, year
}

#Preview("SegmentedControlAtom") {
    @Previewable @State var range: PreviewRange = .week

    VStack(spacing: 24) {
        SegmentedControlAtom(
            selection: $range,
            options: PreviewRange.allCases,
            title: { .verbatim($0.rawValue.capitalized) }
        )

        SegmentedControlAtom(
            selection: $range,
            options: PreviewRange.allCases,
            title: { .verbatim($0.rawValue.capitalized) },
            style: .accent
        )
    }
    .padding()
}
#endif
