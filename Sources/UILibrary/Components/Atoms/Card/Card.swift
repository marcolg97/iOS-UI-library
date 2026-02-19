//
//  Card.swift
//  UILibrary
//
//  Created by Marco La Gala on 13/02/26.
//

import SwiftUI

/// Card è un componente card riutilizzabile.
/// - Displays: generic content
/// - Supports: Dynamic Type, fixed size via frame
/// - Use: inserire `bodyContent` per visualizzare contenuto custom
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
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .fill(style.backgroundColor ?? .clear)
                    .fill(.ultraThinMaterial)
                
            }
            .shadow(color: style.shadowColor, radius: style.shadowRadius, x: style.shadowX, y: style.shadowY)
    }
}

#Preview {
    Card(style: .neutral) {
        VStack(alignment: .leading) {
            Text("This is a card that can have multiple views")
            Button("Tap me") {
                print("Tapped!")
            }
        }
    }
    .frame(width: 300, height: 300)
    
    
    Card(style: .surface) {
        VStack(alignment: .leading) {
            Text("This is a card that can have multiple views")
            Button("Tap me") {
                print("Tapped!")
            }
        }
    }
    .frame(width: 300, height: 300)
}
