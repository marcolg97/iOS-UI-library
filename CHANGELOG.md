# Changelog

## [Unreleased] - 2026-02-18

### Added
- Standardized SwiftDoc for public APIs: `Popup`, `PopupStyle`, `BackgroundStatusBarStyle` and public modifiers (`backgroundStatusBar`, `bannerAndPopup`).
- Unit tests for `PopupStyle`, `BackgroundStatusBarStyle`, and `StatusBarAndPopupModifier` (compile/smoke + behavior).

### Changed
- Made `backgroundStatusBar` and `bannerAndPopup` modifier APIs public and documented them.
- Translated preview strings and documentation comments to English.
- Removed redundant `public` modifiers inside `public extension`s to eliminate compiler warnings.

### Fixed
- Documentation/parameter-name mismatches and missing initializer docs.

### Notes
- No breaking API changes introduced in this set of edits.
- Tests and build verified locally.
