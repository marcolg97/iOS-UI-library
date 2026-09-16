//
//  ScreenHeaderIcon.swift
//  UILibrary
//

import SwiftUI

/// The single-glyph marker that sits above a screen's title — sign-in, password reset, email
/// verification, a paywall, a confirmation.
///
/// One canonical size app-wide is the point: screens that each pick their own icon size are the
/// most common way a set of otherwise consistent screens ends up looking unrelated.
///
/// Not for composed illustrations (layered discs and badges) or full-bleed empty/error state
/// icons — those are different components with different jobs.
public struct ScreenHeaderIcon: View {
    private let systemName: String
    private let style: ScreenHeaderIconStyle

    public init(systemName: String, style: ScreenHeaderIconStyle = ScreenHeaderIconStyle()) {
        self.systemName = systemName
        self.style = style
    }

    public var body: some View {
        Image(systemName: systemName)
            .font(.system(size: style.size, weight: style.weight))
            .symbolRenderingMode(.monochrome)
            .foregroundStyle(style.tint)
            .accessibilityHidden(true)
    }
}

/// Style contract for `ScreenHeaderIcon`.
public struct ScreenHeaderIconStyle: Equatable, Sendable {
    public let size: CGFloat
    public let weight: Font.Weight
    public let tint: Color

    public init(size: CGFloat = 64, weight: Font.Weight = .medium, tint: Color = .accentColor) {
        self.size = size
        self.weight = weight
        self.tint = tint
    }
}

#Preview("Screen header icon") {
    VStack(spacing: 32) {
        ScreenHeaderIcon(systemName: "lock.rotation")
        ScreenHeaderIcon(systemName: "envelope.badge.fill")
        ScreenHeaderIcon(systemName: "party.popper")
    }
    .padding()
}
