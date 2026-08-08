# UI Library — Overview

Welcome to the UILibrary documentation catalog (DocC).

This catalog is the canonical source for generated documentation and contains:

- Architecture and high-level guidelines
- Theming guidance and style contract rules
- Component pages (Atoms / Molecules / Organisms / Templates)
- Implementation-level SwiftDoc exposed from the `Sources/UILibrary` module

Quick links

- [Architecture (migrated)](./LibraryGuidelines.md#architecture)
- [Theming](./Theming.md)
- [Library Guidelines](./LibraryGuidelines.md)

Components

Component reference is authored in-source using SwiftDoc comments and surfaced by DocC as symbol pages. The full, always-current component list lives in the repository `README.md`. Key public symbols:

- Atoms: `ActionButton`, `AvatarImage`, `Badge`, `Card`, `CheckboxAtom`, `Chip`, `CircularProgressBar`, `DividerAtom`, `FormError`, `FormHint`, `FormLabel`, `LabelImage`, `ProgressBar`, `RadioButtonAtom`, `SegmentedControlAtom`, `SkeletonView`, `SwitchAtom`, `TextFieldAtom`, `DismissToolbarItem`
- Molecules: `Banner`, `CarouselView`, `EmptyStateView`, `ErrorStateView`, `FormItem`, `FormSection`, `ListItemCard`, `LoadingStateView`, `SelectableItemCard`, `Toast`, `WeekdayStatusStrip`
- Organisms: `FormContainer`, `TabbarView`, `BackgroundStatusBarView` (via `.backgroundStatusBar(isVisible:style:)`)
- Templates: `LockScreenView`
- Modifiers: `backgroundStatusBar(isVisible:style:)`, `bannerAndPopup(hasToShow:backgroundStatusBarStyle:popupBottomPadding:popupContent:)`, `toast(isPresented:autoDismissAfter:bottomPadding:content:)`, `skeleton(isLoading:style:)`, `scrollDrivenNavigationBarTitle(_:revealAfter:)`, `readHeight(_:)`

Style contract examples:

- `Card` — `Card(style: CardStyle = .neutral, @ViewBuilder bodyContent: () -> BodyContent)` (presets: `.neutral`, `.surface`)
- `ActionButton` — `ActionButton(_: LocalizedStringResource, style: ActionButtonStyle = .primary, action: () -> Void)` (presets: `.primary`, `.secondary`, `.destructive`, `.ghost`, `.tonal`, `.iconCircle`)
- `Toast` — `Toast(icon: String? = nil, message: LocalizedStringResource, style: ToastStyle = .neutral)` (presets: `.warning`, `.error`, `.success`, `.neutral`)
- `BackgroundStatusBarStyle` — `BackgroundStatusBarStyle(backgroundColor: Color, height: CGFloat)` (preset: `.warning`)

> Note: Component reference pages should be authored in-source using SwiftDoc/DocC. Avoid duplicating component API docs as standalone Markdown files to prevent documentation drift.

How to preview locally

- Open the package in Xcode (File → Open..., select `Package.swift`).
- Build documentation: Product → Build Documentation (or Option-Command-Shift-D).
- The DocC catalog will appear in the Documentation viewer with the pages above.

Notes

- The content in this catalog is the single source of truth for the public docs used in the generated DocC site.
- Component reference pages should be authored in-source using SwiftDoc comments; avoid duplicating per-component Markdown files to prevent drift.
