# Changelog

## [Unreleased] - 2026-02-20

### Added

- `Banner` molecule (contextual banner for informational messages with optional actions) + `BannerStyle` and presets (`.info()`, `.warning()`, `.success()`, `.error()`, `.threeDimensionalInfo()`, `.threeDimensionalWarning()`, `.threeDimensionalSuccess()`, `.threeDimensionalError()`).
- Standardized SwiftDoc for public APIs: `Popup`, `PopupStyle`, `BackgroundStatusBarStyle` and public modifiers (`backgroundStatusBar`, `bannerAndPopup`).
- `ActionButton` atom (style-driven, size variants, icon-only and custom label initializers) + `ActionButtonStyle` presets including `.primaryCyan` and `.iconCircle`.
- `AvatarImage` atom (circular avatars showing either an image or the first letter of a name) with fallback-initial logic, plus `AvatarImageStyle` and presets (`.default`, `.small`, `.large`, `.bordered`).
- `Badge` atom (small, style-driven status label for displaying status, count, or tag information) with `BadgeStyle` and presets (`.default`, `.neutral`, `.accent`, `.success`, `.warning`, `.error`, `.outlined(_:)`, `.threeDimensional(_:)`).
- `ProgressBar` atom (determinate, indeterminate and segmented/step variants) + `ProgressBarStyle` and presets (includes new `.threeD` glossy preset).
- Refactored `ProgressBarStyle` to a more coherent structure with separate `Layout`, `Fill`, `Presentation`, `Track`, and `Metrics` types; added detailed SwiftDoc comments and convenience helpers. Updated progress bar implementation and presets to require the new style exclusively.
- Unit tests for `PopupStyle`, `BackgroundStatusBarStyle`, and `StatusBarAndPopupModifier` (compile/smoke + behavior).
- 3D preset styles for `Badge` and `Banner` components with shadow support (`shadowColor`, `shadowRadius`, `shadowOffset` properties added to both `BadgeStyle` and `BannerStyle`).

### Changed

- Made `backgroundStatusBar` and `bannerAndPopup` modifier APIs public and documented them.
- Translated preview strings and documentation comments to English.
- Removed redundant `public` modifiers inside `public extension`s to eliminate compiler warnings.
- `ProgressBar`: default indeterminate animation duration set to 14s for a smoother, slower preview animation.

### Fixed

- Documentation/parameter-name mismatches and missing initializer docs.

### Notes

- No breaking API changes introduced in this set of edits.
- Tests and build verified locally.
