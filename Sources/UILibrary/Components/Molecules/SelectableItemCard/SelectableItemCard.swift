import SwiftUI

/// Generic selectable card with customizable content.
public struct SelectableItemCard<Content: View>: View {
    private let isSelected: Bool
    private let style: SelectableItemCardStyle
    private let action: () -> Void
    @ViewBuilder private let content: () -> Content

    public init(
        isSelected: Bool,
        style: SelectableItemCardStyle = .default,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isSelected = isSelected
        self.style = style
        self.action = action
        self.content = content
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                content()

                Spacer(minLength: 0)

                Group {
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "circle")
                    }
                }
                .font(.title2)
                .foregroundStyle(isSelected ? style.selectedIndicatorColor : style.unselectedIndicatorColor)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .padding(style.padding)
            .background(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .fill(isSelected ? style.selectedBackgroundColor : style.unselectedBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                            .stroke(
                                isSelected ? style.selectedBorderColor : style.unselectedBorderColor,
                                lineWidth: 1
                            )
                    )
            )
            .scaleEffect(isSelected ? style.selectedScale : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var selectedIndex: Int = 0
    
    VStack {
        SelectableItemCard(isSelected: selectedIndex == 0) {
            selectedIndex = 0
        } content: {
            HStack(spacing: 12) {
                Image(systemName: "star.fill")

                VStack(alignment: .leading, spacing: 4) {
                    Text("Title")
                        .font(.headline)
                    Text("This is a card")
                        .font(.subheadline)
                }
            }
        }
        
        SelectableItemCard(isSelected: selectedIndex == 1) {
            selectedIndex = 1
        } content: {
            Text("Custom content row")
                .font(.headline)
        }
    }
    .padding()
}
