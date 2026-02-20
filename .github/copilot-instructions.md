# Copilot Instructions for UILibrary

## Overview

UILibrary is a SwiftUI component library built for multi-app reuse, white-labeling, and long-term scalability. It enforces strict separation of concerns, Atomic Design, and brand-agnosticism. All theming and brand tokens are injected from the consuming app or design system.

IMPORTANT!! Always ask before commit

HOW TO BUILD: swift build --build-system swiftbuild  
HOW TO TEST: swift test --build-system swiftbuild

## Architecture & Structure

- **Atomic Design:** Components are organized as Atoms (primitives), Molecules (compositions), and Organisms (complex UIs).
- **No business logic:** Components are purely presentational. No networking, navigation, analytics, or feature logic.
- **Style Contracts:** Each component exposes a `Style` struct. All visual tokens (colors, typography, spacing) are injected via these contracts.
- **Folder Structure:**
  - `Atoms/`, `Molecules/`, `Organisms/`, `Modifiers/`, `Extensions/`, `Layout/`, `Utilities/`
  - Each component in its own folder: e.g. `Organisms/OfflinePopup/OfflinePopup.swift`, `OfflinePopupStyle.swift`
- **Docs:** Document component APIs in‑source using SwiftDoc/DocC; do not add per‑component Markdown files under `Docs/Components/`.

## Theming & Integration

- **No brand tokens:** UILibrary never contains brand or semantic tokens. All theming is provided by the app or a design system module.
- **Explicit style injection:** Components require a `Style` instance, typically built by a factory in the app layer.
- **Theme switching:** Managed at the app level by recreating style factories and injecting new styles. No global singletons or environment dependencies required.
- **White-label:** Each brand/app provides its own theme and style factories. UILibrary code remains unchanged.

## Developer Workflows

- **Build:** Standard SwiftPM/Xcode build. No custom scripts required.
- **Test:** Tests are in `Tests/UILibraryTests/`. Run via Xcode or `swift test`.
- **Add/Update Component:**
  1. Add or update code in the correct Atomic layer folder.
  2. Update the component's SwiftDoc comments in‑source so DocC generates up‑to‑date API pages (add conceptual articles to `Sources/UILibrary/Documentation.docc/` only when needed).
  3. Update the component list in `README.md`.
  4. Update `CHANGELOG.md` following Semantic Versioning.
  5. Ensure previews compile and cover new variants.
  6. For breaking changes, bump MAJOR version and document migration.

## Project Conventions

- **No brand tokens or business logic in UILibrary.**
- **All public APIs must be documented** with responsibility, layer, and usage context.
- **Style structs must be immutable and brand-agnostic.**
- **Composition over inheritance.** Prefer small, focused views and ViewModifiers.
- **No AnyView unless required.**
- **No environment injection unless necessary.**

## Key References

- [README.md](../README.md): High-level principles, folder structure, and workflow.
- [Library guidelines (architecture)](../Sources/UILibrary/Documentation.docc/LibraryGuidelines.md#ui-library-architecture-guidelines): Architectural rules and examples.
- [Docs/Theming.md](../Sources/UILibrary/Documentation.docc/Theming.md): Theming and style injection strategy.

## Example: Style Injection

```swift
let style = OfflinePopupStyleFactory(theme: currentTheme).error()
OfflinePopup(style: style)
```

## Summary

UILibrary = Structure + Style Contracts  
App/DesignSystem = Theme + Semantic Tokens + Style Builders

Maintain strict separation for scalable, reusable, and brand-independent UI.

---

## Checklist per ogni task

Before considering any change (feature, fix, refactor, breaking change) as complete, always check:

- [ ] Code updated in the correct folder (Atoms/Molecules/Organisms/…)
- [ ] Documentation updated in‑source (SwiftDoc/DocC)
- [ ] Component list updated in `README.md`
- [ ] `CHANGELOG.md` updated following SemVer
- [ ] Previews compile and cover new variants
- [ ] If breaking change: bump MAJOR version and document migration
- [ ] All public APIs documented (responsibility, layer, usage)
- [ ] No brand tokens or business logic in UILibrary
- [ ] Style struct is immutable and brand-agnostic
- [ ] Create a JOURNAL.md entry describing the change, rationale, and any relevant context for future reference.

This checklist must be followed for every PR/task to ensure consistency, quality, and maintainability.

**All documentation, code, and comments must be written in English.**
