//
//  DismissToolbarItem.swift
//  UILibrary
//
//  Created by Marco La Gala on 09/02/26.
//

import SwiftUI

/// A `.cancellationAction` toolbar item that dismisses the current screen with `SheetCloseButton`.
///
/// This is the "X" that belongs in a `.toolbar { }` builder, where a bare `SheetCloseButton` (a
/// `View`) doesn't fit — `DismissToolbarItem` supplies the `ToolbarItem` and placement around it.
/// See `SheetCloseButton` for the styling and fallback behavior.
///
/// ```swift
/// .toolbar {
///     DismissToolbarItem(accessibilityIdentifier: "editor.close") { dismiss() }
/// }
/// ```
public struct DismissToolbarItem: ToolbarContent {
    private let style: SheetCloseButtonStyle
    private let accessibilityIdentifier: String?
    private let dismiss: () -> Void

    public init(
        style: SheetCloseButtonStyle = SheetCloseButtonStyle(),
        accessibilityIdentifier: String? = nil,
        dismiss: @escaping () -> Void
    ) {
        self.style = style
        self.accessibilityIdentifier = accessibilityIdentifier
        self.dismiss = dismiss
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            SheetCloseButton(style: style, accessibilityIdentifier: accessibilityIdentifier) {
                dismiss()
            }
        }
    }
}
