# Journal

## 2026-02-20 — Added 3D preset styles to Badge and Banner

- Extended `BadgeStyle` with shadow properties (`shadowColor`, `shadowRadius`, `shadowOffset`) for 3D effects.
- Added `.threeDimensional(_:)` preset to `BadgeStyle+Preset` supporting customizable base color.
- Extended `BannerStyle` with shadow properties for 3D effects.
- Added 3D presets to `BannerStyle+Preset`: `.threeDimensionalInfo()`, `.threeDimensionalWarning()`, `.threeDimensionalSuccess()`, `.threeDimensionalError()`.
- Updated both `Badge` and `Banner` views to apply shadow modifiers based on style properties.
- Added comprehensive previews demonstrating the 3D style variants for both components.
- Updated `README.md` and `CHANGELOG.md` with new preset documentation.

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
