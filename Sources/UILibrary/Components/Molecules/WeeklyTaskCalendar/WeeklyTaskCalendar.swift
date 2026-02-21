//
//  WeeklyTaskCalendar.swift
//  UILibrary
//
//  Created by Marco La Gala on 16/02/26.
//

import SwiftUI

public struct WeeklyTaskCalendar: View {
    public struct Day: Identifiable, Equatable {
        public let id: Int
        public let label: String
        public let status: Status
    }

    public enum Status: String, Equatable {
        case completed
        case planned
        case upcoming

        var description: String {
            switch self {
            case .completed:
                return "Done"
            case .planned:
                return "Next"
            case .upcoming:
                return "Soon"
            }
        }
    }

    public static let defaultSymbols = ["L", "M", "M", "G", "V", "S", "D"]

    public let days: [Day]
    public let style: WeeklyTaskCalendarStyle

    public init(days: [Day], style: WeeklyTaskCalendarStyle = .default) {
        self.days = days
        self.style = style
    }

    public init(
        studyDays: Set<Int> = [1, 3, 4],
        nextStudyDay: Int? = nil,
        daySymbols: [String] = WeeklyTaskCalendar.defaultSymbols,
        style: WeeklyTaskCalendarStyle = .default
    ) {
        let symbols = daySymbols.count == 7 ? daySymbols : Self.defaultSymbols
        self.style = style
        self.days = (1...7).map { index in
            let status: Status
            if studyDays.contains(index) {
                status = .completed
            } else if nextStudyDay == index {
                status = .planned
            } else {
                status = .upcoming
            }

            return Day(id: index, label: symbols[index - 1], status: status)
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
        let isHighlighted = day.status == .planned
        let circleFill = day.status == .completed ? style.completedBackground : style.plannedBackground
        let borderWidth = isHighlighted ? style.highlightBorderWidth : 0
        let ringColor = day.status == .upcoming ? style.upcomingRingColor : .clear
        let statusTextColor: Color = {
            switch day.status {
            case .completed:
                return style.completedStatusTextColor
            case .planned:
                return style.plannedStatusTextColor
            case .upcoming:
                return style.upcomingStatusTextColor
            }
        }()

        return VStack(spacing: style.daySpacing) {
            Text(day.label)
                .font(style.dayLabelFont)
                .foregroundStyle(style.dayLabelColor)

            ZStack {
                Circle()
                    .fill(circleFill)
                    .frame(width: style.dayCircleSize, height: style.dayCircleSize)
                    .overlay(
                        Circle()
                            .stroke(
                                isHighlighted ? style.highlightBorderColor : ringColor,
                                lineWidth: borderWidth == 0 ? (day.status == .upcoming ? 2 : 0) : borderWidth
                            )
                    )

                if day.status == .completed {
                    Image(systemName: "checkmark")
                        .font(.system(size: style.dayCircleSize * 0.4, weight: .bold))
                        .foregroundStyle(style.completedCheckmarkColor)
                }
            }

            Text(day.status.description)
                .font(style.statusTextFont)
                .foregroundStyle(statusTextColor)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WeeklyTaskCalendar(
        studyDays: [1, 3, 4],
        nextStudyDay: 5
    )
    .padding()
}
