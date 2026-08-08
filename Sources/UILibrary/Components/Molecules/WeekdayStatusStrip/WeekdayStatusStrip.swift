//
//  WeekdayStatusStrip.swift
//  UILibrary
//
//  Created by Marco La Gala on 16/02/26.
//

import SwiftUI

/// Seven-day overview strip that shows a per-day status with a symbol, a
/// status circle, and an optional caption.
///
/// **Layer:** Molecule
///
/// **Responsibility:**
/// Purely presentational weekday strip. The caller decides what each status
/// means (done, scheduled, streak, attendance, …) and supplies localized
/// captions; the component only renders symbols, circles, and captions.
///
/// Day symbols default to the current locale's very-short weekday symbols,
/// starting from the locale's first weekday (Monday in most of Europe,
/// Sunday in the US, Saturday in several Arabic locales).
///
/// **Usage:**
/// ```swift
/// WeekdayStatusStrip(
///     statuses: [.completed, .upcoming, .completed, .completed, .highlighted, .upcoming, .upcoming],
///     captions: [.completed: "Done", .highlighted: "Next"]
/// )
/// ```
public struct WeekdayStatusStrip: View {
    /// A single day cell.
    public struct Day: Identifiable, Sendable {
        /// Visual status of a day. Semantics are defined by the caller.
        public enum Status: Hashable, Sendable {
            /// Filled circle with a checkmark.
            case completed
            /// Emphasized circle with a highlight border.
            case highlighted
            /// Plain circle with a subtle ring.
            case upcoming
        }

        public let id: Int
        /// Short symbol shown above the circle (typically a weekday initial).
        public let label: String
        public let status: Status
        /// Optional caption shown under the circle.
        public let caption: LocalizedStringResource?

        public init(
            id: Int,
            label: String,
            status: Status,
            caption: LocalizedStringResource? = nil
        ) {
            self.id = id
            self.label = label
            self.status = status
            self.caption = caption
        }
    }

    public let days: [Day]
    public let style: WeekdayStatusStripStyle

    /// Creates a strip from fully specified days.
    public init(days: [Day], style: WeekdayStatusStripStyle = .default) {
        self.days = days
        self.style = style
    }

    /// Creates a locale-aware seven-day strip.
    ///
    /// - Parameters:
    ///   - statuses: One status per day, ordered from the locale's first
    ///     weekday. Extra entries are ignored; missing entries default to `.upcoming`.
    ///   - captions: Optional caption for each status, shown under the circles.
    ///   - calendar: Calendar used for weekday symbols and first-weekday
    ///     (default: `.autoupdatingCurrent`).
    ///   - style: Visual tokens (default: `.default`).
    public init(
        statuses: [Day.Status],
        captions: [Day.Status: LocalizedStringResource] = [:],
        calendar: Calendar = .autoupdatingCurrent,
        style: WeekdayStatusStripStyle = .default
    ) {
        let symbols = calendar.veryShortWeekdaySymbols // Sunday-first
        let firstWeekdayIndex = calendar.firstWeekday - 1 // 0-based
        self.style = style
        self.days = (0..<7).map { offset in
            let status = offset < statuses.count ? statuses[offset] : .upcoming
            return Day(
                id: offset,
                label: symbols[(firstWeekdayIndex + offset) % symbols.count],
                status: status,
                caption: captions[status]
            )
        }
    }

    public var body: some View {
        HStack(spacing: style.daySpacing) {
            ForEach(days) { day in
                dayView(day)
            }
        }
        .padding(style.containerPadding)
        .background(
            RoundedRectangle(cornerRadius: style.containerCornerRadius, style: .continuous)
                .fill(style.containerBackgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: style.containerCornerRadius, style: .continuous)
                        .stroke(style.containerBorderColor, lineWidth: 1)
                )
        )
    }

    private func dayView(_ day: Day) -> some View {
        VStack(spacing: style.dayContentSpacing) {
            Text(day.label)
                .font(style.dayLabelFont)
                .foregroundStyle(style.dayLabelColor)

            ZStack {
                Circle()
                    .fill(circleFill(for: day.status))
                    .frame(width: style.dayCircleSize, height: style.dayCircleSize)
                    .overlay(
                        Circle()
                            .stroke(ringColor(for: day.status), lineWidth: ringWidth(for: day.status))
                    )

                if day.status == .completed {
                    Image(systemName: "checkmark")
                        .font(.system(size: style.dayCircleSize * 0.4, weight: .bold))
                        .foregroundStyle(style.completedCheckmarkColor)
                }
            }

            if let caption = day.caption {
                Text(caption)
                    .font(style.captionFont)
                    .foregroundStyle(captionColor(for: day.status))
            }
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(verbatim: day.label))
        .accessibilityValue(day.caption.map { Text($0) } ?? statusAccessibilityValue(for: day.status))
    }

    // MARK: - Status-driven tokens

    private func circleFill(for status: Day.Status) -> Color {
        switch status {
        case .completed: return style.completedBackground
        case .highlighted: return style.highlightedBackground
        case .upcoming: return style.upcomingBackground
        }
    }

    private func ringColor(for status: Day.Status) -> Color {
        switch status {
        case .completed: return .clear
        case .highlighted: return style.highlightBorderColor
        case .upcoming: return style.upcomingRingColor
        }
    }

    private func ringWidth(for status: Day.Status) -> CGFloat {
        switch status {
        case .completed: return 0
        case .highlighted: return style.highlightBorderWidth
        case .upcoming: return style.upcomingRingWidth
        }
    }

    private func captionColor(for status: Day.Status) -> Color {
        switch status {
        case .completed: return style.completedCaptionColor
        case .highlighted: return style.highlightedCaptionColor
        case .upcoming: return style.upcomingCaptionColor
        }
    }

    private func statusAccessibilityValue(for status: Day.Status) -> Text {
        switch status {
        case .completed: return Text("Completed", bundle: .module)
        case .highlighted: return Text("Highlighted", bundle: .module)
        case .upcoming: return Text("Upcoming", bundle: .module)
        }
    }
}

#if DEBUG
#Preview {
    WeekdayStatusStrip(
        statuses: [.completed, .upcoming, .completed, .completed, .highlighted, .upcoming, .upcoming],
        captions: [
            .completed: .verbatim("Done"),
            .highlighted: .verbatim("Next"),
            .upcoming: .verbatim("Soon")
        ]
    )
    .padding()
}

#Preview("Custom days") {
    WeekdayStatusStrip(
        days: (0..<7).map { index in
            WeekdayStatusStrip.Day(
                id: index,
                label: String(index + 1),
                status: index < 3 ? .completed : .upcoming
            )
        }
    )
    .padding()
}
#endif
