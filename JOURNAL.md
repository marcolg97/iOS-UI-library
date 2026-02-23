# Journal

## 2026-02-23 — State View Components (ErrorStateView, EmptyStateView, LoadingStateView)

- Created three new reusable state view molecules using iOS 17+ `ContentUnavailableView`:
  - **ErrorStateView**: Displays error states with icon, title, description, and retry button action
  - **EmptyStateView**: Displays empty states with icon, title, description, and optional action button
  - **LoadingStateView**: Displays loading states with configurable progress indicator (spinner/linear) and optional message
- Introduced style contracts (`ErrorStateViewStyle`, `EmptyStateViewStyle`, `LoadingStateViewStyle`) for complete visual customization
- Added preset factory methods for common use cases:
  - ErrorStateView: `.error()`, `.networkError()`, `.serverError()`, `.custom()`
  - EmptyStateView: `.empty()`
  - LoadingStateView: `.default()`, `.minimal()`, `.linear()`, `.custom()`
- **Localization**: All text parameters use `LocalizedStringResource` following SwiftUI/SPM best practices for automatic string extraction and multi-language support
- Comprehensive previews demonstrating all variants and style presets
- Updated `README.md` component list and `CHANGELOG.md` following semantic versioning

**Technical Decisions:**
1. **ContentUnavailableView**: Chose iOS 17+ `ContentUnavailableView` as the foundation for consistent iOS-native appearance and accessibility support
2. **LocalizedStringResource**: Used `LocalizedStringResource` directly as parameter types (not String) to enable automatic localization extraction during build without manual NSLocalizedString calls
3. **Style Contracts**: Maintained strict separation - components own no brand tokens; all colors, fonts, spacing injected via style structs
4. **ActionButton Integration**: Leveraged existing `ActionButton` component for retry/action buttons, ensuring visual consistency across the library
5. **ControlSize Support**: LoadingStateView supports all ControlSize cases (.mini, .small, .regular, .large, .extraLarge) for flexible spinner sizing
6. **Generic Presets**: Error presets cover common scenarios (network, server) while `.custom()` allows full brand customization

**Rationale:**
Provide brand-agnostic, localization-ready state views that apps can use consistently across error handling, empty states, and loading scenarios. Using `ContentUnavailableView` ensures iOS HIG compliance and future OS updates. The `LocalizedStringResource` approach eliminates manual localization boilerplate and enables compile-time string extraction for Xcode's String Catalog. Style injection maintains UILibrary's core architectural principle: components are presentational shells; apps provide theming.

## 2026-02-20 — Added 3D preset styles to Badge and Banner


## 2026-02-21 — TextFieldAtom atom

- Created `TextFieldAtom` atom for single-line input, supporting error, hint, placeholder, disabled, and focused states.
- Introduced `TextFieldAtomStyle` contract for all visual tokens, fully brand-agnostic and immutable.
- Added style presets and comprehensive previews for all states.
- Updated `README.md` and `CHANGELOG.md`.

Rationale: Provide a reusable, accessible, and brand-agnostic text input primitive for apps and design systems. All theming is injected via `TextFieldAtomStyle`, ensuring strict separation of concerns and long-term scalability. The component supports all required states and accessibility/localization features, following UILibrary's Atomic Design and style-injection conventions.

## 2026-02-21 — CheckboxAtom atom

- Created `CheckboxAtom` atom as a binary selection control supporting error, hint, disabled states, and optional label.
- Introduced `CheckboxAtomStyle` with presets (`.previewDefault`, `.compact`, `.modern`) to cover typical appearances.
- Implemented accessibility labels, values and hints; previews demonstrate all major states.

Rationale: Provide a small, composable, style-driven checkbox primitive for forms and lists. Styling is fully injected by the host app through `CheckboxAtomStyle` so the component remains brand-agnostic and reusable.

## 2026-02-21 — SwitchAtom atom

- Created `SwitchAtom` atom as an on/off toggle supporting error, hint, disabled states, and optional label.
- Introduced `SwitchAtomStyle` with presets (`.previewDefault`, `.compact`, `.modern`) to cover typical appearances.
- Implemented accessibility labels, values and hints; previews demonstrate all major states.

Rationale: Provide a reusable, style-driven switch primitive for settings and form toggles. The style contract keeps the component brand-agnostic and allows apps to inject their own theme.

## 2026-02-21 — RadioButtonAtom atom

- Created `RadioButtonAtom` atom as a single-choice selector supporting error, hint, disabled states, and optional label.
- Introduced `RadioButtonStyle` with presets (`.previewDefault`, `.compact`, `.modern`) to cover typical appearances.
- Implemented accessibility labels, values and hints; previews demonstrate all major states.

Rationale: Provide a compact, style-driven radio primitive for single-choice selections. The style contract ensures brand-agnostic integration and flexible appearance control.
## 2026-02-21 — Beta documentation & component alignment

- Added detailed notes about Carousel, LockScreenView, Tabbar, ListItemCard, SelectableItemCard (+ university wrapper), and WeeklyTaskCalendar so the README's “Component List” now mirrors the actual tree.
- Confirmed DocC/library-guideline references remain accurate for the new molecules and templates.

Rationale: Ensure the first beta ship log and documentation fully describe the current API surface so integrators can discover each component, style contract, and template without guesswork.
Rationale: The 3D style preset provides an elevated, modern appearance option for badges and banners, useful for emphasizing important UI elements or matching specific design languages. Shadow properties are additive (default to nil/0), ensuring full backward compatibility with existing styles. The implementation follows UILibrary's style-injection pattern, keeping the component code generic while allowing apps to choose between flat and 3D presentations.

## 2026-02-20 — Badge atom

- Created `Badge` atom with `BadgeStyle` contract for small status labels and tags.
- Supports customizable colors, typography, padding, corner radius, and optional borders.
- Added `.default` preset and comprehensive previews showing different Badge variants.
- Updated `README.md` and `CHANGELOG.md`.

Rationale: provide a reusable, brand-agnostic Badge primitive for displaying status indicators, counts, and tag-like information across apps. The style contract enables apps to inject their own design tokens while maintaining separation of concerns.

- Added `Banner` molecule supporting informational messages with optional actions.
- Created `BannerStyle` contract with presets (`.info()`, `.warning()`, `.success()`, `.error()`).
- Component supports optional subtitle and custom action content via ViewBuilder.
- Added comprehensive previews demonstrating all style variants.
- Updated `README.md` and `CHANGELOG.md`.

Rationale: Banners provide a flexible, style-driven way to display contextual feedback (info, warnings, success, errors) with optional action buttons. Following UILibrary's architecture, all visual tokens are injected via `BannerStyle`, making the component brand-agnostic and reusable across multiple apps. The molecule layer is appropriate as it combines icon, text, and optional action content into a cohesive UI pattern.

## 2026-02-20 — Centralize onboarding ProgressBar into UILibrary

- Added `ProgressBar` atom supporting determinate, indeterminate and segmented (step) variants.
- Introduced `ProgressBarStyle` with presets and step/segment presentation tokens.
- Added previews and compile-time unit tests.
- Updated `README.md` and `CHANGELOG.md`.

Rationale: extracted onboarding-specific progress UI into a reusable, style-driven atom to remove duplication and follow UILibrary's style-injection and Atomic Design rules.

## 2026-02-20 — AvatarImage atom

- Created `AvatarImage` atom with optional `image` and name-based initial fallback.
- Added `AvatarImageStyle` contract, presets (`.default`, `.small`, `.large`, `.bordered`), and comprehensive previews.
- Updated tests with compile-time smoke and style assertions.
- Updated `README.md`, `CHANGELOG.md`, and added journaling entry.

Rationale: provide a brand-agnostic circular avatar primitive for use across apps; the initial fallback simplifies cases where user photos are unavailable.
