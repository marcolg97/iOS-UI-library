# UI Library — Overview

Welcome to the UILibrary documentation catalog (DocC).

This catalog is the canonical source for generated documentation and contains:

- Architecture and high‑level guidelines
- Theming guidance and style contract rules
- Component pages (Atoms / Molecules / Organisms)
- Implementation-level SwiftDoc exposed from the `Sources/UILibrary` module

Quick links

- [Architecture (migrated)](./LibraryGuidelines.md#architecture)
- [Theming](./Theming.md)
- [Library Guidelines](./LibraryGuidelines.md)

Components

Component reference is authored in-source using SwiftDoc comments and surfaced by DocC as symbol pages. Key public symbols:

- `Card` — `Card(style: CardStyle = .neutral, @ViewBuilder bodyContent: () -> BodyContent)` (style: `CardStyle` — presets: `.neutral`, `.surface`)
- `GhostButton` — `GhostButton(text: LocalizedStringResource, systemName: String? = nil, style: GhostButtonStyle = .neutral, action: () -> Void)` (style: `GhostButtonStyle` — presets: `.neutral`, `.emphasized`)
- `LabelImage` — `LabelImage(style: LabelImageStyle = .neutral, label: () -> LabelContent, icon: () -> IconContent)` (style: `LabelImageStyle` — presets: `.neutral`, `.compact`)
- `Popup` — `Popup(icon: String, message: String, style: PopupStyle = .neutral)`
- `PopupStyle` — `PopupStyle(iconColor:textColor:backgroundColor:)` (presets: `.warning`, `.error`, `.success`, `.neutral`)
- `BackgroundStatusBarStyle` — `BackgroundStatusBarStyle(backgroundColor: Color, height: CGFloat)` (preset: `.warning`)
- Modifiers: `backgroundStatusBar(isVisible:style:)`, `bannerAndPopup(hasToShow:backgroundStatusBarStyle:hasTabBar:popupContent:)`

> Note: Component reference pages should be authored in‑source using SwiftDoc/DocC. Avoid duplicating component API docs as standalone Markdown files to prevent documentation drift.

How to preview locally

- Open the package in Xcode (File → Open..., select `Package.swift`).
- Build documentation: Product → Build Documention (or Option-Command-Shift-D).
- The DocC catalog will appear in the Documentation viewer with the pages above.

Notes

- The content in this catalog is the single source of truth for the public docs used in the generated DocC site.
- Component reference pages should be authored in‑source using SwiftDoc comments; avoid duplicating per‑component Markdown files to prevent drift.
