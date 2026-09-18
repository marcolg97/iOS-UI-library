//
//  PreviewHelpers.swift
//  UILibrary
//
//  Preview utilities for testing components in different contexts.
//

import CustomDump
import SwiftUI

#if DEBUG

// MARK: - Preview Action Logging

/// Logs a `#Preview` action under the member name you spell: `onEditNameTapped:
/// previewLog.onEditNameTapped`. Calling the closure prints that name and `customDump`s any
/// arguments it receives, so previews don't need hand-written `{ print(...) }` closures.
///
/// `@dynamicMemberLookup` hands the member name to the subscript as a compile-time string,
/// which is what makes this work: Swift keeps no runtime record of the argument label a value
/// is passed to, so the name has to be spelled once at the call site — this is the shortest
/// way to do it. The flip side is that it isn't compiler-checked: a typo or a rename of the
/// real parameter leaves the log quietly out of date.
///
/// One generic subscript covers every arity and mixed argument types (`() -> Void`,
/// `(Item) -> Void`, `(String, Int) -> Void`, …) via parameter packs.
@dynamicMemberLookup
public struct PreviewLogger: Sendable {
    public subscript<each Parameter>(dynamicMember name: String) -> (repeat each Parameter) -> Void {
        { (parameter: repeat each Parameter) in
            print("👁️ [Preview] \(name)")
            repeat _ = customDump(each parameter)
        }
    }
}

/// See `PreviewLogger`.
/// ```swift
/// #Preview {
///     AccountCard(account: .success(.preview), onEditNameTapped: previewLog.onEditNameTapped)
/// }
/// ```
public let previewLog = PreviewLogger()

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
