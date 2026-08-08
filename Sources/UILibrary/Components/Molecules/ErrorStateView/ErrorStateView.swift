//
//  ErrorStateView.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// A reusable error state view using ContentUnavailableView with a retry action.
///
/// **Layer:** Molecule
///
/// **Responsibility:**
/// Displays an error state with an icon, title, description, and retry button.
/// All visual tokens are provided via `ErrorStateViewStyle`.
///
/// **Usage:**
/// Inject an `ErrorStateViewStyle` to control colors, spacing, and appearance.
///
/// Example:
/// ```swift
/// // Simple error state
/// ErrorStateView(
///     title: "Connection Failed",
///     description: "Unable to connect to the server. Please check your network.",
///     style: .error(),
///     onRetry: { retry() }
/// )
///
/// // Custom error state
/// ErrorStateView(
///     title: "Oops!",
///     description: "Something went wrong on our end.",
///     style: .custom(
///         iconColor: .red,
///         titleColor: .primary,
///         descriptionColor: .secondary,
///         buttonStyle: .primary
///     ),
///     onRetry: { reload() }
/// )
/// ```
public struct ErrorStateView: View {
    /// The error title displayed prominently.
    private let title: LocalizedStringResource
    
    /// The error description explaining what went wrong.
    private let description: LocalizedStringResource
    
    /// Visual style of the error state view.
    private let style: ErrorStateViewStyle
    
    /// Action to execute when the retry button is tapped.
    private let onRetry: () -> Void
    
    /// Creates an error state view with a retry action.
    ///
    /// - Parameters:
    ///   - title: The error title (localizable).
    ///   - description: The error description (localizable).
    ///   - style: Visual style (default: `.error()`).
    ///   - onRetry: Action to execute when retry button is tapped.
    public init(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        style: ErrorStateViewStyle = .error(),
        onRetry: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.style = style
        self.onRetry = onRetry
    }
    
    public var body: some View {
        ContentUnavailableView {
            Label {
                Text(title)
                    .foregroundStyle(style.titleColor)
            } icon: {
                Image(systemName: style.iconName)
                    .foregroundStyle(style.iconColor)
            }
            .font(style.titleFont)
            .symbolRenderingMode(.hierarchical)
            .imageScale(.large)
        } description: {
            Text(description)
                .font(style.descriptionFont)
                .foregroundStyle(style.descriptionColor)
                .multilineTextAlignment(.center)
        } actions: {
            ActionButton(
                style.retryButtonTitle,
                isEnabled: true,
                style: style.retryButtonStyle,
                action: onRetry
            )
        }
    }
}

#if DEBUG
#Preview("Error State - Network Error") {
    ErrorStateView(
        title: .verbatim("Connection Failed"),
        description: .verbatim("Unable to connect to the server. Please check your internet connection and try again."),
        style: .error(),
        onRetry: {}
    )
}

#Preview("Error State - Server Error") {
    ErrorStateView(
        title: .verbatim("Server Error"),
        description: .verbatim("Something went wrong on our end. We're working to fix it."),
        style: .error(
            iconName: "server.rack",
            retryButtonTitle: .verbatim("Try Again")
        ),
        onRetry: {}
    )
}

#Preview("Error State - Custom Style") {
    @Previewable let customStyle = ErrorStateViewStyle(
        iconName: "exclamationmark.triangle.fill",
        iconColor: .orange,
        titleColor: .primary,
        titleFont: .title2.bold(),
        descriptionColor: .secondary,
        descriptionFont: .body,
        retryButtonTitle: .verbatim("Reload"),
        retryButtonStyle: .init(
            backgroundColor: .orange,
            foregroundColor: .white,
            font: .headline,
            cornerRadius: 8
        )
    )

    ErrorStateView(
        title: .verbatim("Warning"),
        description: .verbatim("Some features may not work properly."),
        style: customStyle,
        onRetry: {}
    )
}
#endif
