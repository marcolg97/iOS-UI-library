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
- Brand-agnostic components (no app copy, no brand colors, no domain concepts)
- Explicit Style Injection (every component takes an immutable `Style` struct)
- No business logic inside components
- Clear dependency direction (App → UILibrary); UILibrary has **zero third-party dependencies**
- Library-owned strings localized via `Bundle.module`; preview copy uses `Text(verbatim:)` / `.verbatim(...)` so it never enters the string catalog
- Accessibility as a requirement: 44pt tap targets, VoiceOver labels/values/traits, Dynamic Type scaling, Reduce Motion respected

---

# Installation (Swift Package Manager)

1. Open Xcode.
2. Add Package Dependency.
3. Insert repository URL.
4. Select version following Semantic Versioning.

Platforms: iOS 17+, macOS 15+ (some utilities such as `ShareSheet` and `Haptics` impact feedback are iOS-only).

---

# Architectural Overview

Layers: Atoms → Molecules → Organisms → Templates, plus Modifiers, Extensions, and Utilities.

Each component:

- Lives in its own folder
- Exposes a `Style` struct (immutable, `Equatable`, `Sendable`)
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
Sources/UILibrary
├── Components/
│   ├── Atoms/
│   ├── Molecules/
│   ├── Organisms/
│   └── Template/
├── Modifiers/
├── Extensions/
├── Utilities/
├── Resources/            (Localizable.xcstrings)
└── Documentation.docc/
```

Each component folder contains:

```
ComponentName/
    ComponentName.swift            (component + #if DEBUG previews)
    ComponentNameStyle.swift
    ComponentNameStyle+Preset.swift
```

---

# Component List

## Atoms

- `ActionButton` — centralized, style-driven button with size variants, icon-only (requires an accessibility label) and custom-content initializers. Presets: `.primary`, `.secondary`, `.destructive`, `.ghost`, `.tonal`, `.iconCircle`.
- `AvatarImage` — circular avatar showing either a supplied image or the first letter of a name. Presets: `.default`, `.small`, `.large`, `.bordered(_:)`.
- `Badge` — small status label for status/count/tag information (`LocalizedStringResource`). Presets: `.default`, `.neutral`, `.accent`, `.success`, `.warning`, `.error`, `.outlined(_:)`, `.threeDimensional(_:)`.
- `Card` — style-driven container with optional color and/or material background, corner radius, padding, shadow, and `expandsHorizontally` control. Presets: `.neutral`, `.surface`.
- `CheckboxAtom` — pure binary toggle (44pt tap target, Dynamic Type scaling). Presets: `.default`, `.compact`, `.modern`.
- `Chip` — tag/filter chip with optional icon, selection state, tap action, and removal affordance. Presets: `.default`, `.outlined`.
- `CircularProgressBar` — determinate ring indicator with optional percentage label; geometry lives in `CircularProgressBarStyle`. Preset: `.default`.
- `DividerAtom` — horizontal or vertical separator with color/thickness/inset tokens. Presets: `.default`, `.inset`.
- `FormError` — error message text with optional icon. Preset: `.default`, `.modern`.
- `FormHint` — helper text for form fields. Preset: `.default`, `.modern`.
- `FormLabel` — text label with optional icon for form fields. Preset: `.default`, `.modern`.
- `LabelImage` — label with a leading or trailing icon. Presets: `.neutral`, `.compact`.
- `ProgressBar` — determinate, indeterminate, and segmented (step) progress presentations. Presets: `.neutral`, `.accent`, `.threeD`, `.bold`, `.segmented`.
- `RadioButtonAtom` — pure single-choice selector with radio (select-only) semantics. Presets: `.default`, `.compact`, `.modern`.
- `SegmentedControlAtom` — segmented picker with a sliding selection indicator over any `Hashable` options. Presets: `.default`, `.accent`.
- `SkeletonView` / `.skeleton(isLoading:)` — shimmering loading placeholder (static under Reduce Motion). Presets: `.default`, `.rounded`.
- `SwitchAtom` — pure on/off toggle. Presets: `.default`, `.compact`, `.modern`.
- `TextFieldAtom` — pure single-line input with error/focused/disabled states; compose with `FormLabel`/`FormHint`/`FormError`. Presets: `.default`, `.compact`, `.modern`.
- `DismissToolbarItem` — toolbar close button with a localized accessibility label.

## Molecules

- `Banner` — contextual banner with icon, title, optional subtitle and action content. Presets: `.info()`, `.warning()`, `.success()`, `.error()` + `threeDimensional` variants.
- `CarouselView` — horizontally scrolling list with snap/paging and optional paging dots, driven by `CarouselViewStyle`.
- `EmptyStateView` — empty state built on `ContentUnavailableView` with optional action. Presets: `.empty()`, `.search()`, `.inbox()`, `.favorites()`, `.list()`, `.custom(...)`.
- `ErrorStateView` — error state with retry action. Presets: `.error()`, `.networkError()`, `.serverError()`, `.custom(...)`.
- `FormItem` — layout container for a single form field (label, input, hint/error); vertical and horizontal layouts.
- `FormSection` — groups related form items with optional localized header and footer.
- `ListItemCard` — generic row card with leading/content/trailing slots (leading/trailing optional) and press feedback. Presets: `.default`, `.prominent`.
- `LoadingStateView` — loading state with spinner or linear indicator and optional message; `expands` token for inline use. Presets: `.default()`, `.minimal()`, `.large()`, `.linear()`, `.custom(...)`.
- `SelectableItemCard` — selectable row with customizable content and a configurable selection indicator.
- `Toast` / `.toast(isPresented:)` — transient message with icon; the modifier adds slide+fade presentation, drag-to-dismiss, and optional auto-dismiss. Presets: `.neutral`, `.success`, `.warning`, `.error`.
- `WeekdayStatusStrip` — locale-aware seven-day status strip (weekday symbols and first weekday from `Calendar`); statuses and captions are caller-defined.

## Organisms

- `FormContainer` — top-level container for form sections (named to avoid colliding with `SwiftUI.Form`). Example:
  ```swift
  ScrollView {
      FormContainer(style: .default) {
          FormSection(header: "Account") {
              FormItem {
                  FormLabel("Username")
                  TextFieldAtom(text: $username, placeholder: "Enter username")
                  FormHint("Between 4-20 characters")
              }
          }
      }
  }
  ```
- `TabbarView` — tab bar built from `TabbarItem` conformances (title, icon, order, optional badge and `TabRole`); supports dynamic tab subsets and `TabbarStyle` tint.
- `BackgroundStatusBarView` — top overlay bar for app-wide status. Modifier: `.backgroundStatusBar(isVisible:style:)`.

## Templates

- `LockScreenView` — full-screen overlay for app lock, configurable via `LockScreenViewContent` (localized, biometric-agnostic) and `LockScreenViewStyle` (material background by default).

## Modifiers

- `.bannerAndPopup(hasToShow:backgroundStatusBarStyle:popupBottomPadding:popupContent:)` — top status bar + dismissable bottom toast for app-wide states.
- `.scrollDrivenNavigationBarTitle(_:revealAfter:)` — reveals the navigation title after a scroll threshold (iOS 18+ automatic; on iOS 17 also attach `.scrollDrivenNavigationBarTitleTracking()` to the scroll content).
- `.toast(isPresented:autoDismissAfter:bottomPadding:content:)` — transient toast presentation.
- `.skeleton(isLoading:style:)` — skeleton placeholder over any view.
- `.readHeight(_:)` — reports a view's height changes.
- `.if(_:transform:)` — conditional modifier (see its documentation for the view-identity caveat).
- `Backport` — availability backports (`backport.navigationSubtitle(_:)`).

## Utilities

- `Haptics` — cross-platform impact/notification feedback.
- `ShareSheet` — `UIActivityViewController` wrapper (iOS only) with excluded activities and completion handler.
- `Theme` — light/dark/system appearance preference (design tokens intentionally live in the app).
- `ViewState` — generic `success/empty/loading/error` view state with accessors.
- `Color(hex:)` / `toHex()` — hex color parsing/serialization.
- `PreviewContainer`, `PreviewSection`, `PreviewVariants`, `LocalizedStringResource.verbatim(_:)` — preview helpers (DEBUG only).

This list must always reflect the current public API. Component API reference must be authored in-source using SwiftDoc/DocC (see "Documentation Structure" below).

---

# Localization Rules

- Every user-facing string owned by the library resolves against the package catalog: `Text("Key", bundle: .module)` or `LocalizedStringResource("Key", bundle: .atURL(Bundle.module.bundleURL))`.
- Public APIs that accept copy from the app take `LocalizedStringResource`, so the app's own catalog is used for app copy.
- Preview and demo strings must use `Text(verbatim:)` or the `.verbatim(...)` helper so they are never extracted into `Localizable.xcstrings`.
- Preview scaffolding types are `private` and wrapped in `#if DEBUG`.

---

# Documentation Structure

All public API documentation must be authored in-source using SwiftDoc/DocC comments. Use `Sources/UILibrary/Documentation.docc/` only for high-level conceptual articles (guides, theming, architecture). Avoid creating per-component Markdown files to prevent documentation drift.

How to preview the DocC catalog locally

- Open the package in Xcode (File → Open... → `Package.swift`).
- Build the documentation: Product → Build Documentation (or Option-Command-Shift-D).
- The DocC catalog is generated from `Sources/UILibrary/Documentation.docc/` and the SwiftDoc comments in `Sources/UILibrary`.

---

# After Updating or Adding a Component

Every change to a public component requires the following steps.

1. **Update the component code** — keep backward compatibility when possible; if a breaking change is required, bump MAJOR (or MINOR pre-1.0) and document the migration.
2. **Update SwiftDoc comments** so DocC generates up-to-date symbol pages.
3. **Update the component list in this README** under the correct Atomic layer.
4. **Update CHANGELOG.md** following the Keep-a-Changelog sections (Added / Changed / Fixed / Removed).
5. **Review public API stability** — no accidental breaking changes; Style structs stay compatible.
6. **Update previews** — `#if DEBUG`, verbatim strings, cover new variants.
7. **Update tests** — construction smoke test + behavior tests where meaningful.

---

# Versioning Strategy

Follow Semantic Versioning:

- MAJOR → Breaking changes
- MINOR → Backward-compatible additions
- PATCH → Fixes

Pre-1.0, breaking changes bump MINOR and must be documented in the CHANGELOG. Never introduce silent breaking changes.

---

# Contribution Rules

Before merging:

- Component follows Atomic Design
- Style struct exists (immutable, `Equatable`, `Sendable`) with a `.default`-style preset
- No brand tokens, app copy, or domain concepts inside UILibrary
- Library strings localized via `Bundle.module`; preview strings verbatim
- Accessibility: labels/traits/values, 44pt targets, Reduce Motion
- Documentation, README component list, and CHANGELOG updated
- `swift build` and `swift test` green

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
