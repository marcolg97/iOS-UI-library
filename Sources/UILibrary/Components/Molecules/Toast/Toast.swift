//
//  Toast.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

import SwiftUI

/// Toast view used to show a short, transient message with an optional icon.
///
/// **Layer:** Molecule
///
/// **Responsibility:**
/// Purely presentational toast/snackbar with an icon and a short message.
/// All visual tokens are provided via `ToastStyle`. Presentation (show/hide,
/// auto-dismiss, drag-to-dismiss) is handled by the `.toast(isPresented:)` modifier.
///
/// **Usage:**
/// ```swift
/// // As a plain view
/// Toast(icon: "info.circle", message: "Saved!", style: .neutral)
///
/// // Presented transiently
/// .toast(isPresented: $showsSavedToast) {
///     Toast(icon: "checkmark.circle", message: "Saved!", style: .success)
/// }
/// ```
public struct Toast: View {

    private let icon: String?
    private let message: LocalizedStringResource
    private let style: ToastStyle

    /// Creates a `Toast`.
    /// - Parameters:
    ///   - icon: Optional system image name displayed on the leading edge.
    ///   - message: Text message to display.
    ///   - style: Visual style to apply (default: `.neutral`).
    public init(
        icon: String? = nil,
        message: LocalizedStringResource,
        style: ToastStyle = .neutral
    ) {
        self.icon = icon
        self.message = message
        self.style = style
    }

    public var body: some View {
        HStack(spacing: style.spacing) {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(style.iconColor)
                    .frame(width: style.iconSize, height: style.iconSize)
                    .accessibilityHidden(true)
            }

            Text(message)
                .foregroundStyle(style.textColor)
                .font(style.font)
        }
        .padding(style.padding)
        .background(
            RoundedRectangle(cornerRadius: style.cornerRadius)
                .fill(style.backgroundColor)
        )
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Presentation modifier

/// Presents a toast at the bottom of the host view with a slide+fade
/// transition, optional auto-dismiss, and drag-to-dismiss.
private struct ToastPresentationModifier<ToastContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let autoDismissAfter: TimeInterval?
    let bottomPadding: CGFloat
    @ViewBuilder let toastContent: () -> ToastContent

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if isPresented {
                    toastContent()
                        .padding(.horizontal, 16)
                        .padding(.bottom, bottomPadding)
                        .transition(
                            reduceMotion
                                ? .opacity
                                : .move(edge: .bottom).combined(with: .opacity)
                        )
                        .gesture(
                            DragGesture(minimumDistance: 10)
                                .onEnded { gestureValue in
                                    if gestureValue.translation.height > 20 {
                                        isPresented = false
                                    }
                                }
                        )
                        .task {
                            guard let autoDismissAfter else { return }
                            try? await Task.sleep(for: .seconds(autoDismissAfter))
                            guard !Task.isCancelled else { return }
                            isPresented = false
                        }
                }
            }
            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8), value: isPresented)
    }
}

public extension View {
    /// Presents transient toast content at the bottom of this view.
    ///
    /// The toast slides in from the bottom, can be dismissed with a downward
    /// drag, and hides automatically after `autoDismissAfter` seconds
    /// (pass `nil` to keep it until dismissed programmatically).
    ///
    /// - Parameters:
    ///   - isPresented: Binding controlling toast visibility. The modifier
    ///     writes `false` back on auto- or drag-dismiss.
    ///   - autoDismissAfter: Seconds before automatic dismissal (default: 3; `nil` disables).
    ///   - bottomPadding: Distance from the bottom edge (default: 20).
    ///   - content: Builder for the toast content (typically a `Toast`).
    func toast<ToastContent: View>(
        isPresented: Binding<Bool>,
        autoDismissAfter: TimeInterval? = 3,
        bottomPadding: CGFloat = 20,
        @ViewBuilder content: @escaping () -> ToastContent
    ) -> some View {
        modifier(
            ToastPresentationModifier(
                isPresented: isPresented,
                autoDismissAfter: autoDismissAfter,
                bottomPadding: bottomPadding,
                toastContent: content
            )
        )
    }
}

#if DEBUG
#Preview {
    VStack(spacing: 16) {
        Toast(
            icon: "exclamationmark.circle",
            message: .verbatim("Something needs your attention"),
            style: .neutral
        )

        Toast(
            icon: "checkmark.circle",
            message: .verbatim("Your changes have been saved."),
            style: .success
        )

        Toast(
            icon: "wifi.slash",
            message: .verbatim("You are offline. Check your connection and try again."),
            style: .warning
        )

        Toast(
            icon: "exclamationmark",
            message: .verbatim("An error occurred. Please try again later."),
            style: .error
        )
    }
    .padding()
}

#Preview("Presented toast") {
    @Previewable @State var isPresented = true

    VStack {
        Button(action: { isPresented = true }) {
            Text(verbatim: "Show toast")
        }
        Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .toast(isPresented: $isPresented) {
        Toast(icon: "checkmark.circle", message: .verbatim("Saved!"), style: .success)
    }
}
#endif
