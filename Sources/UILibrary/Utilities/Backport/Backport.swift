//
//  Backport.swift
//  FeatureCategory
//
//  Created by Marco La Gala on 23/09/25.
//

import SwiftUI

public struct Backport<Content> {
    public let content: Content

    public init(_ content: Content) {
        self.content = content
    }
}

public extension View {
    var backport: Backport<Self> { Backport(self) }
}

public extension Backport where Content: View {
    @ViewBuilder func navigationSubtitle(_ subtitleKey: LocalizedStringResource?) -> some View {
        if let subtitleKey, #available(iOS 26, *) {
            content.navigationSubtitle(subtitleKey)
        } else {
            content
        }
    }
}
