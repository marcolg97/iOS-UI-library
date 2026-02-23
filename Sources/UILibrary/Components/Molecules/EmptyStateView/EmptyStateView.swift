//
//  EmptyStateView.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// A reusable empty state view using ContentUnavailableView with an optional action button.
///
/// **Layer:** Molecule
///
/// **Responsibility:**
/// Displays an empty state with an icon, title, description, and optional action button.
/// All visual tokens are provided via `EmptyStateViewStyle`.
///
/// **Usage:**
/// Inject an `EmptyStateViewStyle` to control colors, spacing, and appearance.
///
/// Example:
/// ```swift
/// // Simple empty state without action
/// EmptyStateView(
///     title: "No Messages",
///     description: "You don't have any messages yet.",
///     style: .empty()
/// )
///
/// // Empty state with action
/// EmptyStateView(
///     title: "No Items Found",
///     description: "Start by adding your first item.",
///     style: .empty(),
///     actionTitle: "Add Item",
///     onAction: { addItem() }
/// )
///
/// // Custom empty state
/// EmptyStateView(
///     title: "Nothing Here",
///     description: "Try adjusting your filters.",
///     style: .custom(
///         iconColor: .blue,
///         titleColor: .primary,
///         descriptionColor: .secondary,
///         buttonStyle: .secondary
///     ),
///     actionTitle: "Clear Filters",
///     onAction: { clearFilters() }
/// )
/// ```
@available(iOS 17.0, macOS 14.0, *)
public struct EmptyStateView: View {
    /// The empty state title displayed prominently.
    private let title: LocalizedStringResource
    
    /// The empty state description explaining the situation.
    private let description: LocalizedStringResource
    
    /// Visual style of the empty state view.
    private let style: EmptyStateViewStyle
    
    /// Optional action button title.
    private let actionTitle: LocalizedStringResource?
    
    /// Optional action to execute when the action button is tapped.
    private let onAction: (() -> Void)?
    
    /// Creates an empty state view without an action button.
    ///
    /// - Parameters:
    ///   - title: The empty state title (localizable).
    ///   - description: The empty state description (localizable).
    ///   - style: Visual style (default: `.empty()`).
    public init(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        style: EmptyStateViewStyle = .empty()
    ) {
        self.title = title
        self.description = description
        self.style = style
        self.actionTitle = nil
        self.onAction = nil
    }
    
    /// Creates an empty state view with an action button.
    ///
    /// - Parameters:
    ///   - title: The empty state title (localizable).
    ///   - description: The empty state description (localizable).
    ///   - style: Visual style (default: `.empty()`).
    ///   - actionTitle: Title for the action button (localizable).
    ///   - onAction: Action to execute when button is tapped.
    public init(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        style: EmptyStateViewStyle = .empty(),
        actionTitle: LocalizedStringResource,
        onAction: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.style = style
        self.actionTitle = actionTitle
        self.onAction = onAction
    }
    
    public var body: some View {
        ContentUnavailableView {
            Label {
                Text(title)
            } icon: {
                Image(systemName: style.iconName)
            }
            .font(style.titleFont)
            .foregroundStyle(style.titleColor)
            .symbolRenderingMode(.hierarchical)
            .imageScale(.large)
        } description: {
            Text(description)
                .font(style.descriptionFont)
                .foregroundStyle(style.descriptionColor)
                .multilineTextAlignment(.center)
        } actions: {
            if let actionTitle, let onAction {
                ActionButton(
                    actionTitle,
                    isEnabled: true,
                    style: style.actionButtonStyle,
                    action: onAction
                )
            }
        }
    }
}

#Preview("Empty State - No Messages") {
    EmptyStateView(
        title: "No Messages",
        description: "You don't have any messages yet. Start a conversation!",
        style: .empty()
    )
}

#Preview("Empty State - With Action") {
    EmptyStateView(
        title: "No Items Found",
        description: "You haven't added any items yet. Get started by adding your first item.",
        style: .empty(),
        actionTitle: "Add Item",
        onAction: {
            print("Add item tapped")
        }
    )
}

#Preview("Empty State - Search Results") {
    EmptyStateView(
        title: "No Results",
        description: "We couldn't find anything matching your search. Try different keywords.",
        style: .search(),
        actionTitle: "Clear Search",
        onAction: {
            print("Clear search tapped")
        }
    )
}

#Preview("Empty State - Custom Style") {
    @Previewable let customStyle = EmptyStateViewStyle(
        iconName: "heart.fill",
        iconColor: .pink,
        titleColor: .primary,
        titleFont: .title.bold(),
        descriptionColor: .secondary,
        descriptionFont: .callout,
        actionButtonStyle: .init(
            backgroundColor: .pink,
            foregroundColor: .white,
            font: .headline,
            cornerRadius: 10
        )
    )
    
    EmptyStateView(
        title: "No Favorites",
        description: "Add items to your favorites to see them here.",
        style: customStyle,
        actionTitle: "Explore",
        onAction: {
            print("Explore tapped")
        }
    )
}
