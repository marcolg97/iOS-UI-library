//
//  BannerAndPopupModifier.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI
import PopupView

/// A view modifier that adds an offline banner and a dismissable popup to any view.
/// - Parameters:
///   - showOfflineBanner: Binding controlling the offline banner visibility.
///   - popupContent: The view to display as the popup.
///   - offlineBannerBackground: The background color for the offline banner.
public struct BannerAndPopupModifier<PopupContent: View>: ViewModifier {
    /// Stato globale offline: controlla la visibilità di entrambi i banner
    @Binding public var isOffline: Bool

    private let popupContent: PopupContent
    private let offlineBannerBackground: Color

    @State private var showPopup: Bool = false

    public init(
        isOffline: Binding<Bool>,
        offlineBannerBackground: Color = .yellow,
        @ViewBuilder popupContent: () -> PopupContent
    ) {
        self._isOffline = isOffline
        self.popupContent = popupContent()
        self.showPopup = isOffline.wrappedValue
        self.offlineBannerBackground = offlineBannerBackground
    }

    public func body(content: Content) -> some View {
        content
            .offlineBanner(
                isVisible: isOffline,
                backgroundColor: offlineBannerBackground
            )
            .popup(isPresented: $showPopup) {
                popupContent
            } customize: {
                $0
                    .type(.floater(verticalPadding: 60))
                    .position(.bottom)
                    .animation(.spring())
            }
            .onChange(of: isOffline) { _, newValue in
                showPopup = newValue
            }
    }
}

public extension View {
    /// Aggiunge barra sopra e banner sotto per stato offline.
    /// - Parameters:
    ///   - isOffline: Binding globale offline (mostra/nasconde entrambi)
    ///   - offlineBannerBackground: Colore della barra superiore
    ///   - popupContent: View da mostrare come banner inferiore
    func bannerAndPopup<PopupContent: View>(
        isOffline: Binding<Bool>,
        offlineBannerBackground: Color = .yellow,
        @ViewBuilder popupContent: () -> PopupContent
    ) -> some View {
        self.modifier(BannerAndPopupModifier(
            isOffline: isOffline,
            offlineBannerBackground: offlineBannerBackground,
            popupContent: popupContent
        ))
    }
}


#if DEBUG
struct BannerAndPopupTestView: View {
    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink("Push detail") {
                    DetailView2()
                }

                Button(isOffline ? "Go Online" : "Go Offline") {
                    isOffline.toggle()
                }
            }
            .navigationTitle("Home")
        }
        .bannerAndPopup(
            isOffline: $isOffline,
            offlineBannerBackground: .yellow
        ) {
            OfflinePopup(message: "You are offline, check your connection and try again", color: .yellow)
        }
    }
}

struct DetailView2: View {
    var body: some View {
        VStack {
            Text("Detail screen")
        }
        .navigationTitle("Detail")
    }
}

// MARK: - Preview

#Preview {
    BannerAndPopupTestView()
}
#endif
