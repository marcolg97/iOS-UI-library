# Journal

## 2026-02-20 — Badge atom
- Created `Badge` atom with `BadgeStyle` contract for small status labels and tags.
- Supports customizable colors, typography, padding, corner radius, and optional borders.
- Added `.default` preset and comprehensive previews showing different Badge variants.
- Updated `README.md` and `CHANGELOG.md`.

Rationale: provide a reusable, brand-agnostic Badge primitive for displaying status indicators, counts, and tag-like information across apps. The style contract enables apps to inject their own design tokens while maintaining separation of concerns.

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
