# Journal

## 2026-02-20 — Banner molecule for contextual messages

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
