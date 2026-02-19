# UI Library

Reusable, brand-agnostic SwiftUI component library built with Atomic Design and strict architectural separation.

This library is designed for:

- Multi-application reuse
- White-label environments
- Long-term scalability
- Explicit theming control

---

# Core Principles

- Atomic Design structure
- Brand-agnostic components
- Explicit Style Injection
- No business logic inside components
- Clear dependency direction (App → UILibrary)
- Strong documentation discipline

---

# Installation (Swift Package Manager)

1. Open Xcode.
2. Add Package Dependency.
3. Insert repository URL.
4. Select version following Semantic Versioning.

---

# Architectural Overview

Layers:

- Atoms
- Molecules
- Organisms

Each component:

- Lives in its own folder
- Exposes a `Style` struct
- Contains no brand tokens
- Contains no feature logic

See `LibraryGuidelines.md` (Architecture section) for full details.

---

# Theming Strategy

This library does NOT own:

- Semantic colors
- Typography
- Spacing tokens

The App (or Design System module) provides them and builds Style instances.

Recommended pattern:

Theme → StyleFactory → Component(style:)

See `Theming.md` for full details.

---

# Folder Structure

```
UILibrary
├── Atoms/
├── Molecules/
├── Organisms/
├── Modifiers/
├── Extensions/
├── Layout/
├── Utilities/
├── Docs/
└── Tests/
```

Each component folder contains:

```
ComponentName/
    ComponentName.swift
    ComponentNameStyle.swift
    ComponentNameConfiguration.swift (if needed)
    ComponentName+Preview.swift
```

---

# Component List

Maintain an updated list of public components.

## Atoms

// (No public Atoms implemented yet)

## Molecules

// (No public Molecules implemented yet)

## Organisms

- **Popup** – Visual notification with icon and message, styled for status/alerts. API: `Popup(icon: String, message: String, style: PopupStyle = .neutral)`
- **BackgroundStatusBarView** – Top overlay bar for app-wide status (e.g. offline, warning). Modifier: `.backgroundStatusBar(isVisible: Bool, style: BackgroundStatusBarStyle)`
- **StatusBarAndPopupModifier** – Adds both a status bar and a dismissable popup to any view for critical states. Modifier: `.bannerAndPopup(isOffline: Binding<Bool>, backgroundStatusBarStyle: BackgroundStatusBarStyle, hasTabbar: Bool, popupContent: () -> PopupContent)`

This list must always reflect the current public API. Component API reference must be authored in‑source using SwiftDoc/DocC (see "Documentation Structure" below).

---

# Documentation Structure

All public API documentation must be authored in‑source using SwiftDoc/DocC comments. Use `Sources/UILibrary/Documentation.docc/` only for high‑level conceptual articles (guides, theming, architecture). Avoid creating per‑component Markdown files to prevent documentation drift.

How to preview the DocC catalog locally

- Open the package in Xcode (File → Open... → `Package.swift`).
- Build the documentation: Product → Build Documentation (or Option‑Command‑Shift‑D).
- The DocC catalog is generated from `Sources/UILibrary/Documentation.docc/` and the SwiftDoc comments in `Sources/UILibrary`.

Notes

- Keep the in‑source SwiftDoc comments as the single source of truth for component API docs; use `Documentation.docc/` for tutorials and conceptual articles only.

---

# Code Documentation Rules

Public API documentation lives in-source (SwiftDoc). Keep `Sources/UILibrary` as the canonical location for component reference comments; use `Sources/UILibrary/Documentation.docc/` for high-level conceptual articles only. See `LibraryGuidelines.md` for the authoritative rules.

---

# After Updating or Adding a Component

Every change to a public component requires the following steps.

## 1. Update the Component Code

- Keep backward compatibility when possible.
- If a breaking change is required, bump MAJOR version and document migration.

## 2. Update Component Documentation

- Update SwiftDoc comments in the component's source files so DocC generates up-to-date symbol pages.
- If you need long-form guidance for a component, add a conceptual article to `Sources/UILibrary/Documentation.docc/` (avoid per-component Markdown duplication).
- Update Style contract description if changed.

## 3. Update Component List in README

- Add new component under correct Atomic layer.
- Remove deprecated components if necessary.

## 4. Update CHANGELOG.md

Follow Semantic Versioning format:

```
## [1.2.0] - 2026-02-18

### Added
- New Badge component

### Changed
- OfflinePopupStyle now supports borderColor

### Fixed
- Layout issue in LabeledIcon
```

Rules:

- Added → new backward-compatible feature
- Changed → behavior modifications
- Fixed → bug fixes
- Removed → breaking removal

## 5. Review Public API Stability

- Verify no accidental breaking changes
- Ensure Style structs remain compatible

## 6. Update Previews

- Ensure preview compiles
- Add preview cases for new variants

## 7. If Breaking Change

- Bump MAJOR version
- Document migration steps in CHANGELOG

---

# Versioning Strategy

Follow Semantic Versioning:

- MAJOR → Breaking changes
- MINOR → Backward-compatible additions
- PATCH → Fixes

Never introduce silent breaking changes.

---

# Contribution Rules

Before merging:

- Component follows Atomic Design
- Style struct exists
- No brand tokens inside UILibrary
- Documentation updated
- README component list updated
- CHANGELOG updated

---

# Long-Term Stability Goals

- Atoms remain highly stable
- Molecules evolve cautiously
- Organisms remain composable
- Public APIs change intentionally

---

# Summary

UILibrary = Structural UI + Style Contracts

DesignSystem / App = Semantic Tokens + Theme + Style Builders

Clear separation ensures scalable and reusable UI architecture.

