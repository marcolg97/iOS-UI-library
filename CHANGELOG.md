# Changelog

## [Unreleased] - 2026-02-18

### Added
- Standardized SwiftDoc for public APIs: `Popup`, `PopupStyle`, `BackgroundStatusBarStyle` and public modifiers (`backgroundStatusBar`, `bannerAndPopup`).
- `ActionButton` atom (style-driven, size variants, icon-only and custom label initializers) + `ActionButtonStyle` presets including `.primaryCyan` and `.iconCircle`.
- `ProgressBar` atom (determinate, indeterminate and segmented/step variants) + `ProgressBarStyle` and presets.
- Unit tests for `PopupStyle`, `BackgroundStatusBarStyle`, and `StatusBarAndPopupModifier` (compile/smoke + behavior).

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
