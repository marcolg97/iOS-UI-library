//
//  SheetCloseButton.swift
//  UILibrary
//

import SwiftUI

/// The top-trailing "X" affordance for a sheet.
///
///
/// Place it in the sheet root's toolbar:
/// ```swift
/// .toolbar { ToolbarItem(placement: .topBarTrailing) { SheetCloseButton { dismiss() } } }
/// ```
///
/// For the common `.cancellationAction` placement, use `DismissToolbarItem` instead, which wraps
/// this view in the `ToolbarItem` for you.
///
/// Pass `isDisabled` while a screen is mid-save rather than swapping in a no-op action: the button
/// must *look* unavailable, and VoiceOver must announce it as such, not silently do nothing.
public struct SheetCloseButton: View {
    private let style: SheetCloseButtonStyle
    private let accessibilityIdentifier: String?
    private let isDisabled: Bool
    private let action: () -> Void

    public init(
        style: SheetCloseButtonStyle = SheetCloseButtonStyle(),
        accessibilityIdentifier: String? = nil,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.style = style
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        Group {
            if #available(iOS 26, macOS 26, *) {
                button
            } else {
                button.background(style.fallbackBackgroundColor, in: Circle())
            }
        }
    }

    // The label and identifier are applied directly on the `Button`, not on the `Group` above
    // (which only picks a style): a container must never be the element carrying an identifier.
    private var button: some View {
        Button(action: action) {
            Image(systemName: style.systemName)
                .font(.system(size: style.glyphSize, weight: .semibold))
                .foregroundStyle(style.glyphColor)
                .frame(width: style.diameter, height: style.diameter)
        }
        .disabled(isDisabled)
        .accessibilityLabel(Text("Close", bundle: .module))
        .optionalAccessibilityIdentifier(accessibilityIdentifier)
    }
}

/// Style contract for `SheetCloseButton`.
public struct SheetCloseButtonStyle: Equatable, Sendable {
    public let systemName: String
    public let glyphColor: Color
    public let glyphSize: CGFloat
    public let diameter: CGFloat
    /// Used only below iOS 26, where Liquid Glass is unavailable.
    public let fallbackBackgroundColor: Color

    public init(
        systemName: String = "xmark",
        glyphColor: Color = .secondary,
        glyphSize: CGFloat = 14,
        diameter: CGFloat = 30,
        fallbackBackgroundColor: Color = Color.primary.opacity(0.08)
    ) {
        self.systemName = systemName
        self.glyphColor = glyphColor
        self.glyphSize = glyphSize
        self.diameter = diameter
        self.fallbackBackgroundColor = fallbackBackgroundColor
    }
}

#Preview("Sheet close button") {
    NavigationStack {
        Text(verbatim: "Sheet content")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    SheetCloseButton(action: {})
                }
            }
    }
}
