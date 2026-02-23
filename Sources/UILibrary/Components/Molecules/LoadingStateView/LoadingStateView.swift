//
//  LoadingStateView.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// A reusable loading state view with a progress indicator and optional message.
///
/// **Layer:** Molecule
///
/// **Responsibility:**
/// Displays a loading state with a spinner/progress indicator and optional text message.
/// All visual tokens are provided via `LoadingStateViewStyle`.
///
/// **Usage:**
/// Inject a `LoadingStateViewStyle` to control colors, spacing, and appearance.
///
/// Example:
/// ```swift
/// // Simple loading state
/// LoadingStateView(
///     message: "Loading...",
///     style: .default()
/// )
///
/// // Loading state without message
/// LoadingStateView(style: .minimal())
///
/// // Custom loading state
/// LoadingStateView(
///     message: "Please wait",
///     style: .custom(
///         progressColor: .blue,
///         messageColor: .secondary,
///         progressSize: .large
///     )
/// )
/// ```
public struct LoadingStateView: View {
    /// Optional loading message to display.
    private let message: LocalizedStringResource?
    
    /// Visual style of the loading state view.
    private let style: LoadingStateViewStyle
    
    /// Creates a loading state view with an optional message.
    ///
    /// - Parameters:
    ///   - message: Optional loading message (localizable).
    ///   - style: Visual style (default: `.default()`).
    public init(
        message: LocalizedStringResource? = nil,
        style: LoadingStateViewStyle = .default()
    ) {
        self.message = message
        self.style = style
    }
    
    public var body: some View {
        VStack(spacing: style.spacing) {
            switch style.progressStyle {
            case .spinner:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(style.progressColor)
                    .scaleEffect(style.progressScale)
                    .controlSize(style.controlSize)
            case .linear:
                ProgressView()
                    .progressViewStyle(.linear)
                    .tint(style.progressColor)
                    .frame(width: style.linearProgressWidth)
            }
            
            if let message {
                Text(message)
                    .font(style.messageFont)
                    .foregroundStyle(style.messageColor)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(style.padding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message != nil ? Text(message!) : Text("Loading", comment: "Default loading accessibility label"))
    }
}

/// Progress style for loading indicator.
public enum LoadingProgressStyle: Equatable, Sendable {
    /// Circular spinner progress indicator.
    case spinner
    
    /// Linear progress bar.
    case linear
}

#Preview("Loading State - Default") {
    LoadingStateView(
        message: "Loading...",
        style: .default()
    )
}

#Preview("Loading State - Without Message") {
    LoadingStateView(style: .minimal())
}

#Preview("Loading State - Large") {
    LoadingStateView(
        message: "Please wait while we load your data",
        style: .large()
    )
}

#Preview("Loading State - Linear") {
    LoadingStateView(
        message: "Processing...",
        style: .linear()
    )
}

#Preview("Loading State - Custom") {
    @Previewable let customStyle = LoadingStateViewStyle(
        progressStyle: .spinner,
        progressColor: .blue,
        progressScale: 1.5,
        controlSize: .large,
        messageColor: .primary,
        messageFont: .headline,
        spacing: 20,
        padding: 40,
        linearProgressWidth: 250
    )
    
    LoadingStateView(
        message: "Custom loading...",
        style: customStyle
    )
}

#Preview("Loading State - In Container") {
    VStack {
        Text("My App")
            .font(.title.bold())
        
        Spacer()
        
        LoadingStateView(
            message: "Fetching your content...",
            style: .default()
        )
        
        Spacer()
    }
    .padding()
}
