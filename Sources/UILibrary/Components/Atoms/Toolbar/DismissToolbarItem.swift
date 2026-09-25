//
//  DismissToolbarItem.swift
//  UILibrary
//
//  Created by Marco La Gala on 09/02/26.
//

import SwiftUI

/// The toolbar item that closes the current modal screen: the system Close button — the standard
/// "xmark", with its Liquid Glass treatment and VoiceOver label — on the **trailing** edge of the
/// navigation bar on iOS.
///
/// Apple's HIG (Toolbars › Navigation): "Use the standard Back and Close buttons… prefer the
/// standard symbols for each, and don't use a text label that says Back or Close." On iOS 26 and
/// later that is `Button(role: .close)`; earlier systems fall back to `SheetCloseButton` (styled by
/// `style`). The item sits in `.topBarTrailing`, where the system's own sheets put it, so a screen
/// whose primary action lives at the bottom never shows a leading "Cancel" — pair it with a
/// bottom action, not with a bar Done button. On macOS it stays a `.cancellationAction`.
///
/// ```swift
/// .toolbar {
///     DismissToolbarItem(accessibilityIdentifier: "editor.close") { dismiss() }
/// }
/// ```
///
/// `ToolbarContent` is not a `View`, so `.disabled(_:)` cannot be applied to this from the outside.
/// That is what `isDisabled` is for — use it while a screen is mid-save instead of passing a no-op
/// closure, which would leave the X looking and sounding available while doing nothing.
public struct DismissToolbarItem: ToolbarContent {
    private let style: SheetCloseButtonStyle
    private let accessibilityIdentifier: String?
    private let isDisabled: Bool
    private let dismiss: () -> Void

    public init(
        style: SheetCloseButtonStyle = SheetCloseButtonStyle(),
        accessibilityIdentifier: String? = nil,
        isDisabled: Bool = false,
        dismiss: @escaping () -> Void
    ) {
        self.style = style
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isDisabled = isDisabled
        self.dismiss = dismiss
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: Self.placement) {
            if #available(iOS 26, macOS 26, *) {
                Button(role: .close, action: dismiss)
                    .disabled(isDisabled)
                    .if(accessibilityIdentifier != nil) { $0.accessibilityIdentifier(accessibilityIdentifier ?? "") }
            } else {
                SheetCloseButton(
                    style: style,
                    accessibilityIdentifier: accessibilityIdentifier,
                    isDisabled: isDisabled
                ) {
                    dismiss()
                }
            }
        }
    }

    private static var placement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarTrailing
        #else
        .cancellationAction
        #endif
    }
}
