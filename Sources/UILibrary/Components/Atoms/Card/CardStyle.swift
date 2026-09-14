import SwiftUI

/// Style contract for `Card`.
///
/// - Responsibility: Visual tokens for `Card` (background, corner radius, padding, shadow).
/// - Note: Immutable and brand-agnostic; apps should provide concrete colors via style factories.
///
/// ## `backgroundColor` and `material` are mutually exclusive in practice
/// Both tokens *can* be set at once — `Card` draws `material` first and `backgroundColor` on top of
/// it (see `Card.body`) — but doing so rarely produces a useful result: unless `backgroundColor` is
/// partially transparent, its opaque fill completely obscures the material underneath, so the
/// material is wasted. Pick one per style, matching the "flat vs. glass" look you want:
/// - **Flat surface**: set `backgroundColor`, leave `material` `nil` (see `.surface`).
/// - **Glass/translucent surface**: set `material`, leave `backgroundColor` `nil` (see `.neutral`).
///
/// If you do need both (e.g. a translucent color tint over a material), give `backgroundColor` an
/// explicit opacity — a fully opaque `backgroundColor` alongside a non-nil `material` is very
/// likely a mistake.
public struct CardStyle: Equatable, Sendable {
    /// Material backing for the card surface.
    ///
    /// Wraps `SwiftUI.Material` in an `Equatable`/`Sendable` token so it can live in a style contract.
    public enum Material: Equatable, Sendable {
        case ultraThin
        case thin
        case regular
        case thick
        case ultraThick

        var shapeStyle: SwiftUI.Material {
            switch self {
            case .ultraThin: return .ultraThinMaterial
            case .thin: return .thinMaterial
            case .regular: return .regularMaterial
            case .thick: return .thickMaterial
            case .ultraThick: return .ultraThickMaterial
            }
        }
    }

    /// Optional flat surface color. See the mutual-exclusivity note on `CardStyle` above — pair
    /// this with `material == nil` unless you deliberately want a translucent color over glass.
    public let backgroundColor: Color?
    /// Optional glass/translucent surface. See the mutual-exclusivity note on `CardStyle` above —
    /// pair this with `backgroundColor == nil` for a pure glass surface.
    public let material: Material?
    public let expandsHorizontally: Bool
    public let cornerRadius: CGFloat
    public let padding: CGFloat
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    public let shadowX: CGFloat
    public let shadowY: CGFloat

    /// Creates a `CardStyle`.
    /// - Parameters:
    ///   - backgroundColor: Optional surface color for the card, drawn above `material` when both are set.
    ///   - material: Optional material backing for the card surface.
    ///   - expandsHorizontally: Whether the card fills the available width (`true`) or hugs its content (`false`).
    ///   - cornerRadius: Corner radius for the card surface.
    ///   - padding: Internal content padding.
    ///   - shadowColor: Shadow color.
    ///   - shadowRadius: Shadow blur radius.
    ///   - shadowX: Horizontal shadow offset.
    ///   - shadowY: Vertical shadow offset.
    public init(
        backgroundColor: Color? = nil,
        material: Material? = nil,
        expandsHorizontally: Bool = true,
        cornerRadius: CGFloat = 12,
        padding: CGFloat = 12,
        shadowColor: Color = .black.opacity(0.1),
        shadowRadius: CGFloat = 2,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 1
    ) {
        self.backgroundColor = backgroundColor
        self.material = material
        self.expandsHorizontally = expandsHorizontally
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
    }
}
