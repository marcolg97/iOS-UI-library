//
//  LockScreenView.swift
//  UILibrary
//
//  Created by Marco La Gala on 08/02/26.
//

import SwiftUI

/// Lock screen overlay shown when app lock is enabled.
///
/// This view:
/// - Covers the entire app content when locked (opaque material background by default)
/// - Shows a lock icon, title, subtitle, and an unlock button
/// - Invokes `onUnlock` when the button is tapped; triggering the actual
///   authentication (biometrics, passcode, …) is the app's responsibility
public struct LockScreenView: View {
    private let content: LockScreenViewContent
    private let style: LockScreenViewStyle
    private let onUnlock: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isAnimating = false

    public init(
        onUnlock: @escaping () -> Void,
        content: LockScreenViewContent = .default,
        style: LockScreenViewStyle = .default
    ) {
        self.content = content
        self.style = style
        self.onUnlock = onUnlock
    }

    public var body: some View {
        ZStack {
            if style.usesMaterialBackground {
                Rectangle()
                    .fill(.regularMaterial)
                    .ignoresSafeArea()
            }

            style.backgroundColor
                .ignoresSafeArea()

            VStack(spacing: style.verticalSpacing) {
                Spacer()

                Image(systemName: content.iconSystemName)
                    .font(.system(size: style.iconSize))
                    .foregroundStyle(style.iconColor)
                    .scaleEffect(isAnimating && !reduceMotion ? 1.0 : 0.9)
                    .animation(
                        reduceMotion
                            ? nil
                            : .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                    .accessibilityHidden(true)

                VStack(spacing: style.textSpacing) {
                    Text(content.title)
                        .font(style.titleFont)
                        .foregroundStyle(style.titleColor)

                    Text(content.subtitle)
                        .font(style.subtitleFont)
                        .foregroundStyle(style.subtitleColor)
                        .multilineTextAlignment(.center)
                }
                .accessibilityElement(children: .combine)

                Spacer()

                Button {
                    onUnlock()
                } label: {
                    HStack {
                        Image(systemName: content.unlockIconSystemName)
                            .font(.title3)
                            .accessibilityHidden(true)
                        Text(content.unlockButtonTitle)
                            .font(style.buttonFont)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(style.buttonBackgroundColor)
                    .foregroundStyle(style.buttonForegroundColor)
                    .clipShape(.rect(cornerRadius: style.buttonCornerRadius))
                }
                .padding(.horizontal, style.horizontalPadding)
                .padding(.bottom, style.bottomPadding)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#if DEBUG
#Preview {
    LockScreenView(
        onUnlock: {},
        content: .default,
        style: .default
    )
}
#endif
