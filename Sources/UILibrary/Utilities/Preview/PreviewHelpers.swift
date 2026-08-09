//
//  PreviewHelpers.swift
//  UILibrary
//
//  Preview utilities for testing components in different contexts.
//

import SwiftUI

#if DEBUG

// MARK: - Preview Container

/// A container for SwiftUI previews that provides context labels and styling.
///
/// Use this to organize multiple preview variants with clear labels.
///
/// ## Usage
/// ```swift
/// #Preview("States") {
///     PreviewContainer {
///         PreviewSection("Default") {
///             MyComponent()
///         }
///         PreviewSection("Dark Mode") {
///             MyComponent()
///                 .preferredColorScheme(.dark)
///         }
///     }
/// }
/// ```
public struct PreviewContainer<Content: View>: View {
    @ViewBuilder private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                content()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

/// A labeled section within a preview.
///
/// Displays content with an optional header label for organization.
public struct PreviewSection<Content: View>: View {
    private let title: String?
    @ViewBuilder private let content: () -> Content

    public init(_ title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                Text(verbatim: title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
            }
            content()
        }
    }
}

// MARK: - Verbatim Strings for Previews

public extension LocalizedStringResource {
    /// Wraps a raw string so previews can pass sample copy to APIs that take
    /// `LocalizedStringResource` without registering a key in the string catalog.
    ///
    /// Preview-only convention: real library strings must use proper
    /// localization; preview copy must never be extracted for translation.
    static func verbatim(_ string: String) -> LocalizedStringResource {
        LocalizedStringResource("\(string)")
    }
}

// MARK: - Accessibility Preview Modifiers

public extension View {
    /// Enables Dynamic Type at specified size for preview testing.
    ///
    /// - Parameter size: Content size category (e.g., .accessibilityExtraExtraExtraLarge)
    func previewDynamicType(_ size: DynamicTypeSize) -> some View {
        environment(\.dynamicTypeSize, size)
    }

    /// Enables right-to-left layout for preview testing.
    ///
    /// Simulates Arabic, Hebrew, or other RTL languages.
    func previewRTL() -> some View {
        environment(\.layoutDirection, .rightToLeft)
    }
}

// MARK: - Grouped Variants Preview

/// Displays a component in all common variants for comprehensive testing.
///
/// Shows: Default, Dark Mode, RTL, Large Text
///
/// **Note:** Reduce Motion and Increase Contrast cannot be previewed directly.
/// Test these using Simulator settings (Settings → Accessibility).
///
/// ## Usage
/// ```swift
/// #Preview("All Variants") {
///     PreviewVariants {
///         MyComponent()
///     }
/// }
/// ```
public struct PreviewVariants<Content: View>: View {
    @ViewBuilder private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        PreviewContainer {
            PreviewSection("Default (Light)") {
                content()
            }

            PreviewSection("Dark Mode") {
                content()
                    .environment(\.colorScheme, .dark)
            }

            PreviewSection("Right-to-Left (RTL)") {
                content()
                    .previewRTL()
            }

            PreviewSection("Large Text (XXXL)") {
                content()
                    .previewDynamicType(.accessibility3)
            }
        }
    }
}

#endif
