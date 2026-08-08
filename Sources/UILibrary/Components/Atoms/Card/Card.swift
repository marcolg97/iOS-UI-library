//
//  Card.swift
//  UILibrary
//
//  Created by Marco La Gala on 13/02/26.
//

import SwiftUI

/// Reusable card container for grouping related content.
/// - Displays: generic content
/// - Supports: Dynamic Type, fixed size via frame
/// - Use: provide `bodyContent` to display custom content
public struct Card<BodyContent: View>: View {
    private let style: CardStyle
    private let bodyContent: () -> BodyContent

    /// Creates a card with injectable visual style.
    /// - Parameters:
    ///   - style: `CardStyle` describing visual tokens. Default: `.neutral`.
    ///   - bodyContent: Content displayed inside the card.
    public init(
        style: CardStyle = .neutral,
        @ViewBuilder bodyContent: @escaping () -> BodyContent
    ) {
        self.style = style
        self.bodyContent = bodyContent
    }

    public var body: some View {
        bodyContent()
            .padding(style.padding)
            .frame(maxWidth: style.expandsHorizontally ? .infinity : nil)
            .background {
                ZStack {
                    if let material = style.material {
                        RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                            .fill(material.shapeStyle)
                    }
                    if let backgroundColor = style.backgroundColor {
                        RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                            .fill(backgroundColor)
                    }
                }
            }
            .shadow(color: style.shadowColor, radius: style.shadowRadius, x: style.shadowX, y: style.shadowY)
    }
}

#if DEBUG
#Preview {
    Card(style: .neutral) {
        VStack(alignment: .leading) {
            Text(verbatim: "This is a card that can have multiple views")
            Button(action: {}) {
                Text(verbatim: "Tap me")
            }
        }
    }
    .frame(width: 300)

    Card(style: .surface) {
        VStack(alignment: .leading) {
            Text(verbatim: "This is a card that can have multiple views")
            Button(action: {}) {
                Text(verbatim: "Tap me")
            }
        }
    }
    .frame(width: 300)
}
#endif
