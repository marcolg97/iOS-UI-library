import SwiftUI

public extension ProgressBarStyle {
    /// Default neutral style used in many examples.
    ///
    /// - Gray track color, accent‑colored fill, continuous layout, flat presentation.
    static let neutral = ProgressBarStyle(
        layout: .continuous,
        fill: .solid(.accentColor),
        presentation: .flat,
        track: .default,
        metrics: .default
    )

    /// Accent variant – provides an explicit track tint while keeping the
    /// progress fill tied to `accentColor`.
    static let accent = ProgressBarStyle(
        layout: .continuous,
        fill: .solid(.accentColor),
        presentation: .flat,
        track: .init(color: Color.primary.opacity(0.1)),
        metrics: .default
    )

    /// Glossy 3‑D appearance suitable for high‑impact, playful UI elements.
    ///
    /// Uses the accent color for fill and glow, darker track and the 3‑D presentation tokens.
    static let threeD = ProgressBarStyle(
        layout: .continuous,
        fill: .solid(.accentColor),
        presentation: .threeD(.default),
        track: .init(color: Color.primary.opacity(0.1)),
        metrics: .init(height: 8, cornerRadius: 6, indeterminateDuration: Metrics.default.indeterminateDuration)
    )

    /// Tall, glossy variant for prominent progress displays.
    static let bold = ProgressBarStyle(
        layout: .continuous,
        fill: .solid(.green),
        presentation: .threeD(.default),
        track: .init(color: Color.primary.opacity(0.1)),
        metrics: .default.withHeight(20)
    )

    /// Segmented/step layout preset for onboarding flows.
    static let segmented = ProgressBarStyle(
        layout: .segmented(.default),
        fill: .solid(.accentColor),
        presentation: .flat,
        track: .default,
        metrics: .default
    )
}

public extension ProgressBarStyle.Presentation.ThreeD {
    static let `default` = ProgressBarStyle.Presentation.ThreeD(
        glowColor: Color.accentColor.opacity(0.28),
        highlightColor: Color.white.opacity(0.28),
        shadowRadius: 6
    )
}

public extension ProgressBarStyle.Metrics {
    static let `default` = ProgressBarStyle.Metrics(
        height: 6,
        cornerRadius: 3,
        indeterminateDuration: 14
    )

    func withHeight(_ height: CGFloat) -> Self {
        .init(height: height, cornerRadius: cornerRadius, indeterminateDuration: indeterminateDuration)
    }
}

public extension ProgressBarStyle.Layout.Segmented {
    static let `default` = ProgressBarStyle.Layout.Segmented(
        activeWidth: 50,
        inactiveWidth: 25,
        spacing: 4,
        textColor: .primary.opacity(0.6)
    )
}

public extension ProgressBarStyle.Track {
    static let `default` = ProgressBarStyle.Track(color: Color.primary.opacity(0.12))
}
