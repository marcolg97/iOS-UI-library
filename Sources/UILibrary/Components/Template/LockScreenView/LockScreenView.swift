//
//  LockScreenView.swift
//  CleanExpenseTracker
//
//  Created by Marco La Gala on 08/02/26.
//

import SwiftUI

/// Lock screen overlay shown when biometric lock is enabled.
///
/// This view:
/// - Covers the entire app content when locked
/// - Shows app icon and unlock prompt
/// - Provides retry button if authentication fails
/// - Automatically triggers biometric authentication
public struct LockScreenView: View {
    private let content: LockScreenViewContent
    private let style: LockScreenViewStyle
    private let onUnlock: () -> Void

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
            style.backgroundColor
                .ignoresSafeArea()

            VStack(spacing: style.verticalSpacing) {
                Spacer()

                Image(systemName: content.iconSystemName)
                    .font(.system(size: style.iconSize))
                    .foregroundStyle(style.iconColor)
                    .scaleEffect(isAnimating ? 1.0 : 0.9)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: isAnimating
                    )

                VStack(spacing: 12) {
                    Text(content.title)
                        .font(style.titleFont)
                        .foregroundStyle(style.titleColor)

                    Text(content.subtitle)
                        .font(style.subtitleFont)
                        .foregroundStyle(style.subtitleColor)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                Button {
                    onUnlock()
                } label: {
                    HStack {
                        Image(systemName: content.unlockIconSystemName)
                            .font(.title3)
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

#Preview {
    LockScreenView(
        onUnlock: { print("Unlock tapped") },
        content: .default,
        style: .default
    )
}
