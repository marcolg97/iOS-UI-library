import SwiftUI

/// Visual tokens describing **how** a ``ProgressBar`` should render. The style is
/// completely agnostic to any business logic – it simply declares colors, sizes,
/// and effects. Callers obtain or construct a style (often from one of the presets)
/// and pass it down to the view.
///
/// Styles are immutable and `Equatable` so they can be compared in tests or reused
/// across multiple components without duplication.
public struct ProgressBarStyle: Equatable, Sendable {

    /// Horizontal layout of the bar. See ``Layout``.
    public let layout: Layout

    /// Fill information (solid color or gradient).
    public let fill: Fill

    /// Additional presentation decorations (flat vs 3‑D).
    public let presentation: Presentation

    /// Track (background) color.
    public let track: Track

    /// Size and timing metrics.
    public let metrics: Metrics

    /// Creates a new style. Every argument has a default so the plain
    /// ``init()`` expression yields a neutral, continuous bar using the accent
    /// color for progress and a light gray track.
    public init(
        layout: Layout,
        fill: Fill,
        presentation: Presentation,
        track: Track,
        metrics: Metrics
    ) {
        self.layout = layout
        self.fill = fill
        self.presentation = presentation
        self.track = track
        self.metrics = metrics
    }
}

// MARK: - Nested types

public extension ProgressBarStyle {

    /// Determines whether the bar fills continuously or in discrete segments/steps.
    enum Layout: Equatable, Sendable {
        /// Standard continuous bar where progress is represented by a single
        /// growing capsule.
        case continuous

        /// Segmented/step style used for onboarding flows or multi‑step processes.
        case segmented(Segmented)

        /// Configuration for the segmented layout.
        public struct Segmented: Equatable, Sendable {
            public let activeWidth: CGFloat
            public let inactiveWidth: CGFloat
            public let spacing: CGFloat
            public let textColor: Color?

            public init(
                activeWidth: CGFloat,
                inactiveWidth: CGFloat,
                spacing: CGFloat,
                textColor: Color
            ) {
                self.activeWidth = activeWidth
                self.inactiveWidth = inactiveWidth
                self.spacing = spacing
                self.textColor = textColor
            }
        }
    }
}

public extension ProgressBarStyle {

    /// Describes how the progressing portion of the bar should be painted.
    enum Fill: Equatable, Sendable {
        /// A simple solid color.
        case solid(Color)

        /// A gradient (horizontal, leading→trailing).
        case gradient(Gradient)
    }
}

public extension ProgressBarStyle {

    /// Track appearance tokens.
    struct Track: Equatable, Sendable {
        public let color: Color

        public init(color: Color) {
            self.color = color
        }
    }
}

public extension ProgressBarStyle {

    /// Additional visual presentation options layered on top of the fill.
    enum Presentation: Equatable, Sendable {
        /// No extra decorations – flat rendering.
        case flat

        /// Gloss, glow and shadow to simulate depth.
        case threeD(ThreeD)

        /// Tokens used by the 3‑D presentation.
        public struct ThreeD: Equatable, Sendable {
            public let glowColor: Color
            public let highlightColor: Color
            public let shadowRadius: CGFloat
            
            public init(
                glowColor: Color,
                highlightColor: Color,
                shadowRadius: CGFloat
            ) {
                self.glowColor = glowColor
                self.highlightColor = highlightColor
                self.shadowRadius = shadowRadius
            }
        }
    }
}

public extension ProgressBarStyle {

    /// Size and timing metrics.
    struct Metrics: Equatable, Sendable {
        public let height: CGFloat
        public let cornerRadius: CGFloat
        public let indeterminateDuration: Double

        public init(
            height: CGFloat,
            cornerRadius: CGFloat,
            indeterminateDuration: Double
        ) {
            self.height = height
            self.cornerRadius = cornerRadius
            self.indeterminateDuration = indeterminateDuration
        }
    }
}

// MARK: - Convenience accessors

public extension ProgressBarStyle {
    var trackColor: Color { track.color }

    var progressColor: Color {
        switch fill {
        case let .solid(c): return c
        case let .gradient(g):
            return g.stops.first?.color ?? .accentColor
        }
    }

    var progressGradientStartColor: Color? {
        guard case let .gradient(g) = fill else { return nil }
        return g.stops.first?.color
    }

    var progressGradientEndColor: Color? {
        guard case let .gradient(g) = fill else { return nil }
        return g.stops.last?.color
    }

    var threeDConfig: Presentation.ThreeD? {
        if case let .threeD(cfg) = presentation { return cfg }
        return nil
    }

    var segmentedConfig: Layout.Segmented {
        if case let .segmented(cfg) = layout { return cfg }
        return .default
    }

    var height: CGFloat { metrics.height }
    var cornerRadius: CGFloat { metrics.cornerRadius }
    var indeterminateAnimationDuration: Double { metrics.indeterminateDuration }
}
