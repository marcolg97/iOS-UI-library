# Changelog

## [Unreleased] - 2026-02-21

### Added

- **NEW Form Architecture** – Introduced scalable, composable form components following iOS HIG and modern SwiftUI patterns:
  - `Form` organism – Top-level container for form sections providing consistent spacing and styling
  - `FormSection` molecule – Groups related form items with optional header and footer
  - `FormItem` molecule – Layout container for a single form field (label, input, hint/error) with vertical and horizontal layouts
  - `FormLabel` atom – Text label with optional icon for form fields
  - `FormHint` atom – Helper text for form fields
  - `FormError` atom – Error message text with optional icon
- Style contracts for all new form components: `FormStyle`, `FormSectionStyle`, `FormItemStyle`, `FormLabelStyle`, `FormHintStyle`, `FormErrorStyle`
- Preset styles for all new form components (`.previewDefault`, `.modern`, `.compact` variants where applicable)
- Comprehensive previews demonstrating form composition patterns

### Changed (BREAKING)

- **BREAKING:** `TextFieldAtom` – Removed `label`, `error`, `hint` properties. Now purely an input control. Compose with `FormLabel`, `FormHint`, and `FormError` in `FormItem` for complete form fields.
- **BREAKING:** `CheckboxAtom` – Removed `label`, `error`, `hint` properties. Now purely a toggle control. Compose with `FormLabel` for complete form fields.
- **BREAKING:** `RadioButtonAtom` – Removed `label`, `error`, `hint` properties. Now purely a selector control. Compose with `FormLabel` for complete form fields.
- **BREAKING:** `SwitchAtom` – Removed `label`, `error`, `hint` properties. Now purely a toggle control. Compose with `FormLabel` for complete form fields.
- **BREAKING:** `TextFieldAtomStyle` – Removed `hintFont`, `hintColor`, `errorTextColor`, `spacing` properties. Style now focuses only on input appearance.
- **BREAKING:** `CheckboxStyle` – Removed `spacing`, `contentSpacing`, `font`, `hintFont`, `labelColor`, `hintColor`, `errorColor` properties.
- **BREAKING:** `RadioButtonStyle` – Removed `spacing`, `contentSpacing`, `font`, `hintFont`, `labelColor`, `hintColor`, `errorColor` properties.
- **BREAKING:** `SwitchAtomStyle` – Removed `spacing`, `contentSpacing`, `font`, `hintFont`, `labelColor`, `hintColor`, `errorColor` properties.
- **BREAKING:** Updated all preset styles (`.previewDefault`, `.compact`, `.modern`) to match simplified style contracts.

### Removed (BREAKING)

- **BREAKING:** `FormRow` molecule – Removed in favor of the new composable `Form`, `FormSection`, and `FormItem` architecture.
- **BREAKING:** `FormRowStyle` – Removed. Use individual style contracts for `FormItem`, `FormLabel`, etc.
- **BREAKING:** `FormRowLayout` and `FormRowContentPlacement` – Replaced by `FormItemLayout` in the new architecture.

### Migration Guide

**Old pattern (FormRow):**
```swift
FormRow(label: "Username", error: error, style: formRowStyle) {
    TextFieldAtom(text: $username, placeholder: "Enter username", style: textFieldStyle)
}
```

**New pattern (Form architecture):**
```swift
Form(style: formStyle) {
    FormSection {
        FormItem(layout: .vertical, style: itemStyle) {
            FormLabel("Username", style: labelStyle)
            TextFieldAtom(text: $username, placeholder: "Enter username", hasError: error != nil, style: textFieldStyle)
            if let error = error {
                FormError(error, style: errorStyle)
            }
        }
    }
}
```

**Benefits of the new architecture:**
- Truly atomic atoms (single responsibility)
- Maximum flexibility and composability
- Native SwiftUI feel with `Form { Section { Item { } } }` pattern
- Easier to create custom layouts
- Better scalability for complex forms

## [Unreleased] - 2026-02-20

### Added

- `Banner` molecule (contextual banner for informational messages with optional actions) + `BannerStyle` and presets (`.info()`, `.warning()`, `.success()`, `.error()`, `.threeDimensionalInfo()`, `.threeDimensionalWarning()`, `.threeDimensionalSuccess()`, `.threeDimensionalError()`).
- Standardized SwiftDoc for public APIs: `Popup`, `PopupStyle`, `BackgroundStatusBarStyle` and public modifiers (`backgroundStatusBar`, `bannerAndPopup`).
- `ActionButton` atom (style-driven, size variants, icon-only and custom label initializers) + `ActionButtonStyle` presets including `.primaryCyan` and `.iconCircle`.
- `AvatarImage` atom (circular avatars showing either an image or the first letter of a name) with fallback-initial logic, plus `AvatarImageStyle` and presets (`.default`, `.small`, `.large`, `.bordered`).
- `Badge` atom (small, style-driven status label for displaying status, count, or tag information) with `BadgeStyle` and presets (`.default`, `.neutral`, `.accent`, `.success`, `.warning`, `.error`, `.outlined(_:)`, `.threeDimensional(_:)`).
- `ProgressBar` atom (determinate, indeterminate and segmented/step variants) + `ProgressBarStyle` and presets (includes new `.threeD` glossy preset).
- Refactored `ProgressBarStyle` to a more coherent structure with separate `Layout`, `Fill`, `Presentation`, `Track`, and `Metrics` types; added detailed SwiftDoc comments and convenience helpers. Updated progress bar implementation and presets to require the new style exclusively.
 - `CheckboxAtom` atom (binary, style-injected toggle with optional label, hint, error and disabled states. All visual tokens are injected via `CheckboxAtomStyle`. Previews cover default, checked, disabled, error, modern and compact variants.)
 - `SwitchAtom` atom (on/off, style-injected toggle with optional label, hint, error and disabled states. All visual tokens are injected via `SwitchAtomStyle`. Previews cover default, on, disabled, error, modern and compact variants.)
 - `RadioButtonAtom` atom (single-choice, style-injected selector with optional label, hint, error and disabled states. All visual tokens are injected via `RadioButtonStyle`. Previews cover default, selected, disabled, error, modern and compact variants.)
- Unit tests for `PopupStyle`, `BackgroundStatusBarStyle`, and `StatusBarAndPopupModifier` (compile/smoke + behavior).
- 3D preset styles for `Badge` and `Banner` components with shadow support (`shadowColor`, `shadowRadius`, `shadowOffset` properties added to both `BadgeStyle` and `BannerStyle`).

### Changed

- Made `backgroundStatusBar` and `bannerAndPopup` modifier APIs public and documented them.
- Translated preview strings and documentation comments to English.
- Removed redundant `public` modifiers inside `public extension`s to eliminate compiler warnings.
- `ProgressBar`: default indeterminate animation duration set to 14s for a smoother, slower preview animation.

### Fixed

 - `TextFieldAtom` atom (single-line, style-injected input field supporting error, hint, placeholder, disabled, and focused states. All visual tokens are injected via `TextFieldAtomStyle`. Previews cover all states. Brand-agnostic and accessible.)

