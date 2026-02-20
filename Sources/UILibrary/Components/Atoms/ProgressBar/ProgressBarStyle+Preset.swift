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
        track: .init(color: Color.gray.opacity(0.18)),
        metrics: .default
    )

    /// Glossy 3‑D appearance suitable for high‑impact, playful UI elements.
    ///
    /// Uses a solid cyan‑blue fill, darker track and the 3‑D presentation tokens.
    static let threeD = ProgressBarStyle(
        layout: .continuous,
        fill: .solid(Color(red: 0.00, green: 0.78, blue: 0.92)),
        presentation: .threeD(.default),
        track: .init(color: Color.black.opacity(0.25)),
        metrics: .init(height: 8, cornerRadius: 6, indeterminateDuration: Metrics.default.indeterminateDuration)
    )
    
    static let quizStyle = ProgressBarStyle(
        layout: .continuous,
        fill: .solid(.green),
        presentation: .threeD(.default),
        track: .init(color: Color.black.opacity(0.25)),
        metrics: .default.withHeight(20)
    )
}

public extension ProgressBarStyle.Presentation.ThreeD {
    static let `default` = ProgressBarStyle.Presentation.ThreeD(
        glowColor: Color(red: 0.00, green: 0.78, blue: 0.92).opacity(0.28),
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
        spacing: 4
    )
}

public extension ProgressBarStyle.Track {
    static let `default` = ProgressBarStyle.Track(color: Color.primary.opacity(0.12))
}
