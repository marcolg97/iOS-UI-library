//
//  OfflineBannerOverlay.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

struct OfflineBannerOverlay: ViewModifier {

    let isVisible: Bool
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isVisible {
                    OfflineStatusBanner(
                        backgroundColor: backgroundColor
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: isVisible)
    }
}

extension View {
    func offlineBanner(
        isVisible: Bool,
        backgroundColor: Color = .orange
    ) -> some View {
        modifier(
            OfflineBannerOverlay(
                isVisible: isVisible,
                backgroundColor: backgroundColor
            )
        )
    }
}
