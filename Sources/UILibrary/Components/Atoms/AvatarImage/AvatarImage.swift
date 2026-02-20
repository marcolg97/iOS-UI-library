import SwiftUI

/// A circular avatar component that displays either a supplied image or the
/// first letter of a provided name. Use this view wherever a user/avatar
/// representation is needed without introducing brand‑specific imagery.
///
/// The appearance is fully driven by an injected ``AvatarImageStyle``. If
/// the caller passes `nil` for `image` the component falls back to rendering a
/// text initial computed from the first character of `name` (uppercased).
///
/// ## Usage
/// ```swift
/// AvatarImage(name: "Alice")
/// AvatarImage(name: "Bob", image: Image("profile_pic"))
/// AvatarImage(name: "Charlie", style: .large.bordered(.blue))
/// ```
public struct AvatarImage: View {
    private let image: Image?
    private let name: String
    private let style: AvatarImageStyle

    /// Creates an avatar. The `image` argument is optional; if omitted the
    /// component will display the uppercased first letter of `name` instead.
    ///
    /// - Parameters:
    ///   - name: Full name used for the accessibility label and initial.
    ///   - image: Optional image to render inside the circle. Should be
    ///     square; the view applies `.scaledToFill()` and clips to the circle.
    ///   - style: Visual tokens configuring the size, colors, and typography.
    public init(
        name: String,
        image: Image? = nil,
        style: AvatarImageStyle = .default
    ) {
        self.name = name
        self.image = image
        self.style = style
    }

    private var initial: String {
        guard
            let first = name.trimmingCharacters(in: .whitespacesAndNewlines).first
        else { return "" }
        return String(first).uppercased()
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(style.backgroundColor)
                .frame(width: style.size, height: style.size)

            if let img = image {
                img
                    .resizable()
                    .scaledToFill()
                    .frame(width: style.size, height: style.size)
                    .clipShape(Circle())
            } else {
                Text(initial)
                    .font(style.font)
                    .foregroundColor(style.textColor)
            }
        }
        .overlay(
            Group {
                if let border = style.borderColor {
                    Circle()
                        .stroke(border, lineWidth: style.borderWidth)
                }
            }
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(name))
    }
}

#Preview("Avatar with image") {
    AvatarImage(name: "Alice", image: Image(systemName: "person.crop.circle"))
}

#Preview("Initial fallbacks") {
    HStack(spacing: 16) {
        AvatarImage(name: "alice")
        AvatarImage(name: " Bob")
        AvatarImage(name: "")
    }
}

#Preview("Styles") {
    HStack(spacing: 20) {
        AvatarImage(name: "David", style: .small)
        AvatarImage(name: "Eve", style: AvatarImageStyle.bordered())
        AvatarImage(name: "Frank", style: .large)
    }
}
