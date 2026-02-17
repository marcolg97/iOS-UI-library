//
//  OfflineStatusBanner.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

struct OfflineStatusBanner: View {
    let backgroundColor: Color
    let height: CGFloat = 40

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 0)
                Text("")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    
            }
            .frame(height: height*1.5)
            .background(backgroundColor)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .top)
        }
    }
}

#if DEBUG
struct OfflineBannerTestView: View {

    @State private var isOffline = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink("Push detail") {
                    DetailView()
                }

                Button(isOffline ? "Go Online" : "Go Offline") {
                    isOffline.toggle()
                }
            }
            .navigationTitle("Home")
        }
        .offlineBanner(
            isVisible: isOffline,
            backgroundColor: .yellow
        )
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail screen")
        }
        .navigationTitle("Detail")
    }
}

// MARK: - Preview

#Preview {
    OfflineBannerTestView()
}
#endif
