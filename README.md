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
 - `TextFieldAtom` — single-line, style-injected input field supporting error, hint, placeholder, disabled, and focused states. All visual tokens are injected via `TextFieldAtomStyle`. Previews cover all states. Brand-agnostic and accessible.
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

- `ActionButton` — centralized, style-driven button with size variants, icon-only and custom-content initializers. Use `ActionButtonStyle` presets (`.primary`, `.secondary`, `.destructive`, `.ghost`, `.primaryCyan`, `.iconCircle`).
- `AvatarImage` — circular avatar that shows either a supplied image or the first letter of a name when no image is provided. Appearance is controlled via `AvatarImageStyle` with presets such as `.default`, `.small`, `.large` and `bordered(_:)`.
- `Badge` — small, style-driven status label for displaying status, count, or tag-like information. Use `BadgeStyle` presets (`.default`, `.neutral`, `.accent`, `.success`, `.warning`, `.error`, `.outlined(_:)`, `.threeDimensional(_:)`).
- `Card` — style-driven container for grouping related content with customizable background, border, shadow, and padding. Use `CardStyle` presets (`.default`, `.elevated`, `.outlined`, `.flat`).
- `LabelImage` — combines a label with an optional leading or trailing system icon. Use `LabelImageStyle` to control typography, colors, and layout.
- `ProgressBar` — style-driven progress indicator supporting determinate, indeterminate and segmented (step) presentations. Build a custom look by composing tokens from `ProgressBarStyle` (layout, fill, presentation, track, metrics); built‑in presets include `.neutral`, `.accent` and `.threeD`.
- `TextFieldAtom` — pure single-line input field without labels, hints, or errors. Compose with `FormLabel`, `FormHint`, and `FormError` for complete form fields. Appearance is controlled via `TextFieldAtomStyle` with presets such as `.previewDefault`, `.compact`, and `.modern`.
- `CheckboxAtom` — pure binary toggle without labels, hints, or errors. Compose with `FormLabel`, `FormHint`, and `FormError` for complete form fields. Appearance is controlled via `CheckboxStyle` with presets such as `.previewDefault`, `.compact`, and `.modern`.
- `SwitchAtom` — pure on/off toggle without labels, hints, or errors. Compose with `FormLabel`, `FormHint`, and `FormError` for complete form fields. Appearance is controlled via `SwitchAtomStyle` with presets such as `.previewDefault`, `.compact`, and `.modern`.
- `RadioButtonAtom` — pure single-choice selector without labels, hints, or errors. Compose with `FormLabel`, `FormHint`, and `FormError` for complete form fields. Appearance is controlled via `RadioButtonStyle` with presets such as `.previewDefault`, `.compact`, and `.modern`.
- `FormLabel` — text label with optional icon for form fields. Compose with input atoms in `FormItem`. Appearance is controlled via `FormLabelStyle`.
- `FormHint` — helper text for form fields. Appearance is controlled via `FormHintStyle`.
- `FormError` — error message text with optional icon for form fields. Appearance is controlled via `FormErrorStyle`.

## Molecules

- `Banner` – Contextual banner for displaying informational messages with optional actions. Supports info, warning, success, and error styles in both flat and 3D variants. API: `Banner(title: String, subtitle: String? = nil, style: BannerStyle = .info(), actionContent: () -> ActionContent)`. Use presets: `.info()`, `.warning()`, `.success()`, `.error()`, `.threeDimensionalInfo()`, `.threeDimensionalWarning()`, `.threeDimensionalSuccess()`, `.threeDimensionalError()`.
- `FormItem` — layout container for a single form field (label, input, hint/error). Supports vertical and horizontal layouts. API: `FormItem(layout: FormItemLayout = .vertical, style: FormItemStyle) { /* content */ }`.
- `FormSection` — groups related form items with optional header and footer. API: `FormSection(header: String? = nil, footer: String? = nil, style: FormSectionStyle) { /* items */ }`.

## Organisms

- `Form` – Top-level container for form sections providing consistent spacing and optional styling. API: `Form(style: FormStyle) { /* sections */ }`. Example usage:
  ```swift
  Form(style: formStyle) {
      FormSection(header: "Account") {
          FormItem(layout: .vertical, style: itemStyle) {
              FormLabel("Username", style: labelStyle)
              TextFieldAtom(text: $username, style: textFieldStyle)
              FormHint("Between 4-20 characters", style: hintStyle)
          }
      }
  }
  ```
- `Popup` – Visual notification with icon and message, styled for status/alerts. API: `Popup(icon: String, message: String, style: PopupStyle = .neutral)`.
- `BackgroundStatusBarView` – Top overlay bar for app-wide status (e.g. offline, warning). Modifier: `.backgroundStatusBar(isVisible: Bool, style: BackgroundStatusBarStyle)`.
- `StatusBarAndPopupModifier` – Adds both a status bar and a dismissable popup to any view for critical states. Modifier: `.bannerAndPopup(isOffline: Binding<Bool>, backgroundStatusBarStyle: BackgroundStatusBarStyle, hasTabbar: Bool, popupContent: () -> PopupContent)`.

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
