import SwiftUI

/// FormItem Molecule
///
/// Layer: Molecule
/// Responsibility: Layout container for a single form field with label, input, and optional hint/error.
/// Supports horizontal and vertical layouts. Purely structural—no visual styling.
public struct FormItem<Content: View>: View {
    // MARK: - Private stored properties
    private let layout: FormItemLayout
    private let style: FormItemStyle
    @ViewBuilder private let content: () -> Content

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    // MARK: - Init
    public init(
        layout: FormItemLayout = .vertical,
        style: FormItemStyle = .default,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.layout = layout
        self.style = style
        self.content = content
    }

    /// The concrete layout to render, resolving `.adaptive` against the current Dynamic Type size.
    private var resolvedLayout: FormItemLayout.Resolved {
        layout.resolved(for: dynamicTypeSize)
    }

    // MARK: - Body
    public var body: some View {
        switch resolvedLayout {
        case .vertical:
            VStack(alignment: .leading, spacing: style.spacing) {
                content()
            }
        case .horizontal:
            HStack(alignment: .center, spacing: style.spacing) {
                content()
            }
        }
    }
}

/// Layout options for FormItem.
public enum FormItemLayout: Equatable, Sendable {
    /// Always stacks content vertically.
    case vertical
    /// Always lays out content horizontally in a single row.
    case horizontal
    /// Behaves like `.horizontal` at standard Dynamic Type sizes, and switches to `.vertical`
    /// once `dynamicTypeSize.isAccessibilitySize` is true — so a label/value row (e.g. a
    /// `FormLabel` + trailing control) reflows into a stack instead of truncating or being
    /// squeezed at accessibility text sizes.
    case adaptive

    /// The two concrete layouts `.adaptive` resolves to.
    enum Resolved {
        case vertical
        case horizontal
    }

    /// Resolves this layout against a Dynamic Type size — `.adaptive` becomes `.vertical` at
    /// accessibility sizes and `.horizontal` otherwise; `.vertical`/`.horizontal` pass through
    /// unchanged regardless of Dynamic Type size.
    func resolved(for dynamicTypeSize: DynamicTypeSize) -> Resolved {
        switch self {
        case .vertical:
            return .vertical
        case .horizontal:
            return .horizontal
        case .adaptive:
            return dynamicTypeSize.isAccessibilitySize ? .vertical : .horizontal
        }
    }
}

#if DEBUG
#Preview("FormItem — Layouts") {
    @Previewable @State var username = ""
    @Previewable @State var notificationsEnabled = true
    @Previewable @State var acceptTerms = false

    VStack(spacing: 24) {
        // Vertical layout (default)
        FormItem(layout: .vertical, style: .default) {
            FormLabel(.verbatim("Username"), systemImage: "person", style: .default)
            TextFieldAtom(text: $username, placeholder: .verbatim("Enter username"), style: .default)
            FormHint(.verbatim("Between 4-20 characters"), style: .default)
        }

        // Horizontal layout
        FormItem(layout: .horizontal, style: .default) {
            FormLabel(.verbatim("Notifications"), style: .default)
            Spacer()
            SwitchAtom(isOn: $notificationsEnabled, style: .default)
        }

        // Horizontal with checkbox
        FormItem(layout: .horizontal, style: .default) {
            CheckboxAtom(isOn: $acceptTerms, style: .default)
            FormLabel(.verbatim("Accept terms and conditions"), style: .default)
        }

        // With error
        FormItem(layout: .vertical, style: .default) {
            FormLabel(.verbatim("Email"), systemImage: "envelope", style: .default)
            TextFieldAtom(text: .constant("invalid"), placeholder: .verbatim("your@email.com"), style: .default)
            FormError(.verbatim("Invalid email address"), style: .default)
        }
    }
    .padding()
}

#Preview("FormItem — Adaptive layout") {
    PreviewVariants {
        FormItem(layout: .adaptive, style: .default) {
            FormLabel(.verbatim("Guests"), style: .default)
            Spacer()
            Text(verbatim: "8 confirmed")
                .foregroundStyle(.secondary)
        }
    }
}
#endif
