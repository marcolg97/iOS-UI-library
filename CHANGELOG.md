# Changelog

## [0.4.2] - 2026-09-21

### Fixed

- **`SettingsRow` broke apart at accessibility Dynamic Type sizes.** Title and accessory share one line, and at those sizes neither fits: both collapse into narrow hyphenated columns ("Pro-me-mo-ria" beside "Non attivi"). The accessory now drops below the title once `dynamicTypeSize.isAccessibilitySize` is true — the same adaptation `FormItem`'s `.adaptive` layout already makes. No API change.

## [0.4.1] - 2026-09-21

### Added

- **`headerTracking` on `SettingsGroupStyle`.** A design system whose small-caps section headers are tracked out could not reproduce them through `SettingsGroup`: tracking is a view modifier, not part of `Font`, so `headerFont` alone cannot carry it, and the group's header would sit visibly tighter than every other section header on the same screen. Defaults to `0`, so nothing changes for anyone not setting it.

## [0.4.0] - 2026-09-21

### Added

- **`SettingsRow` (Molecule) and `SettingsGroup` (Organism)** — the settings-list idiom, which the library had no answer for. `ListItemCard` gives every row its own card, which is right for a list of events and wrong for a screen of settings: a column of separate cards reads as an unsorted pile rather than as groups. `SettingsGroup` puts one surface behind several `SettingsRow`s and draws a divider *between* them, never under the last one.
- `SettingsGroup` takes `[SettingsRow]` instead of a `@ViewBuilder`. SwiftUI offers no public way to take a view builder apart, so a builder-based group cannot tell where one row ends and the next begins — it would have to make every row draw its own trailing divider, and `Card` does not clip, so the last one would be drawn across the card's rounded bottom edge. Passing rows as values makes the boundaries explicit and lets the group keep the divider inset in step with `SettingsRowStyle.textInset`.
- An empty `rows` array renders nothing, header included, so a caller can filter rows behind feature flags without also deciding whether the group still has anything left to show.

### Changed

- `PressScaleButtonStyle` moved out of `ListItemCard.swift` into `Utilities/`, so `SettingsRow` and `ListItemCard` share one press feedback instead of two copies drifting apart. Still internal — no public API change.

## [0.3.2] - 2026-09-20

### Fixed

- **The dismiss "X" drew two nested circles.** `SheetCloseButton` applied `.buttonStyle(.glass)` from iOS 26, but a bar already draws that material behind its buttons, so the two stacked into a rounded glass capsule with a second circle inside it around the glyph. The `.glass` style is gone: from iOS 26 the button is the bare glyph and the bar supplies the chrome. Below iOS 26 nothing supplies it, so the tinted circular fallback stays. `DismissToolbarItem` keeps rendering `SheetCloseButton`, so there is still exactly one X in the library. No API change.
- Note for consumers: a snapshot taken through `.image(layout: .sizeThatFits)` cannot catch this class of bug. That host lays the toolbar out but never composites the bar's real material, so the doubled chrome is invisible there and shows only on a device or simulator.

## [0.3.1] - 2026-09-20

### Added

- **`isDisabled` on `SheetCloseButton` and `DismissToolbarItem`.** A sheet often needs its dismiss "X" unavailable while a save is in flight, and there was no way to express that. `SheetCloseButton` is a `View`, so `.disabled(_:)` worked on it, but `DismissToolbarItem` is `ToolbarContent` — not a `View` — so no view modifier can be applied to it from the outside at all. The only workaround left to a consumer was to pass a no-op closure while busy, which is the wrong fix twice over: the X still renders at full opacity so it looks tappable, and VoiceOver still announces an available button that then silently does nothing. Both types now take `isDisabled: Bool = false`, applied to the underlying `Button`, so the control dims and reports itself as disabled the way every other disabled control does. Additive with a default, so fully source compatible.

## [0.3.0] - 2026-09-20

### Changed

- **One implementation of the sheet-dismiss "X".** `DismissToolbarItem` and `SheetCloseButton` implemented the same dismiss affordance twice, differently: `SheetCloseButton` uses Liquid Glass (`.buttonStyle(.glass)`) on iOS 26 and a tinted circular fallback below it, while `DismissToolbarItem` drew a bare `Image(systemName: "xmark")` with no background, sizing, or styling at all. `DismissToolbarItem` now renders `SheetCloseButton` inside its `ToolbarItem(placement: .cancellationAction)`, so there is exactly one "X" in the library. It also gained `style: SheetCloseButtonStyle = SheetCloseButtonStyle()` and `accessibilityIdentifier: String? = nil` parameters (kept in `SheetCloseButton`'s parameter order: `style`, `accessibilityIdentifier`, then the closure), since `DismissToolbarItem` previously offered no way to set an identifier at all, which blocked any consumer whose UI tests match on identifiers from using it. **This is source compatible** — both parameters are additive with defaults, so `DismissToolbarItem { dismiss() }` keeps compiling unchanged — **but it is not visually compatible**: every existing call site now renders the styled Liquid Glass/circular-fallback button instead of the old bare glyph. Any snapshot test that captures a screen using `DismissToolbarItem` will need re-recording.

### Fixed

- **`SheetCloseButton`'s accessibility identifier could land on a container instead of the button.** The identifier and accessibility label were applied to the `Group` that picks between the iOS-26 Liquid Glass style and the older fallback, rather than to the `Button` itself. They now sit directly on the `Button`, inside the `button` computed property, before the per-OS-version style modifier is layered on — so the identifier is always attached to the actual tappable, VoiceOver-focusable element, never to the wrapping container. This matters because the consuming app's UI-testing convention is that an accessibility identifier must never sit on a container that would swallow its children's identifiers.

### Localization

- **Added Italian localizations for the entire string catalog.** `Localizable.xcstrings` shipped with 34 keys and zero `localizations` entries — every string had a `comment` and `extractionState` but no translated value at all, so the library rendered English text (via its raw key) inside any app, English or not, and gave an Italian-shipping consumer no `it` string to fall back to. Every key now carries both an explicit `en` entry (the key text itself, `state: "translated"`) and an `it` translation, so the library's own accessibility labels/values (`Checkbox`, `Loading`, `Retry`, `Step %lld of %lld`, etc.) read correctly in an Italian UI instead of leaking English. `comment` and `extractionState` are unchanged for every key.

## [0.2.3] - 2026-09-15

### Added

- **`SegmentedControlAtom` per-segment accessibility identifiers.** New optional `accessibilityIdentifier: ((Option) -> String?)?` parameter (default `nil`) lets callers attach a UI-testing identifier to each individual segment button (e.g. `accessibilityIdentifier: { "editor.range.\($0)" }`), the same way a native `Picker(.segmented)`'s buttons or a hand-rolled row of options can be addressed by XCUITest. The identifier is applied to the segment's own tappable element, never to the shared container, so segments stay independently addressable and the container never overrides its children. Fully source compatible — the parameter is additive with a default, and every existing call site keeps compiling unchanged.

### Documentation

- Confirmed `RadioButtonAtom`, `CheckboxAtom`, and `Chip` need no API change for the same UI-testing need: unlike `SegmentedControlAtom`, these are already instantiated per item by the caller (e.g. inside the caller's own `ForEach`), so `.accessibilityIdentifier(_:)` can already be applied directly to each instance today. Also confirmed `SegmentedControlAtom` already exposes each segment to VoiceOver as a selectable element with the correct `.isSelected` trait — no change was needed there.

## [0.2.2] - 2026-09-14

### Added

- `QuantityStepper` atom — compact `−`/`+` stepper for small integer quantities (`value: Binding<Int>`, `accessibilityLabel:`, `range:`, `step:`, `isDisabled:`), built on `ActionButton.iconCircle`. Exposed to VoiceOver as a single adjustable element (label + current value, swipe up/down), the same pattern as SwiftUI's own `Stepper`. `QuantityStepperStyle` with `.default`/`.compact` presets.
- `BadgeStyle.dot(_:diameter:)` preset and `Badge.dot(accessibilityLabel:style:)` — a minimal circular dot variant of `Badge` (no visible text) for lightweight status indicators, replacing hand-rolled `Circle()` views. `BadgeStyle` gained a `dotDiameter: CGFloat?` token (default `nil`, fully backward compatible).
- `FormItemLayout.adaptive` — behaves like `.horizontal` at standard Dynamic Type sizes and switches to `.vertical` once `dynamicTypeSize.isAccessibilitySize` is true, so a label/value row reflows instead of truncating or being squeezed at accessibility text sizes.

### Fixed

- **`scrollDrivenNavigationBarTitle` title stays invisible on non-scrolling screens.** The modifier's opacity was purely threshold-driven (`scrollOffset > revealAfter`), so content shorter than the scroll view's viewport could never cross `revealAfter` and the title stayed at `opacity(0)` forever. The modifier now also measures content/viewport height (via `ScrollGeometry` on iOS 18+, via an additional preference key on iOS 17) and shows the title at full opacity immediately when the content isn't scrollable; when it is scrollable, opacity now ramps continuously with scroll offset instead of snapping between 0 and 1 at the threshold. The opacity calculation is extracted into a pure, unit-tested function (`titleOpacity(scrollOffset:contentHeight:viewportHeight:threshold:)`). Public API is unchanged and source-compatible.

### Documentation

- `CardStyle` docc now explicitly documents that `backgroundColor` and `material` are mutually exclusive in practice: both can be set, but `Card` draws `backgroundColor` opaquely on top of `material`, so an opaque `backgroundColor` alongside a non-nil `material` wastes the material. No API change.

## [0.2.0] - 2026-08-07

Full library review and hardening pass: the library is now fully app-agnostic, localized, dependency-free, and accessible.

### Added

- **New atoms**: `Chip` (tag/filter with selection and removal, `ChipStyle` presets `.default`, `.outlined`), `SegmentedControlAtom` (sliding-indicator segmented picker, `SegmentedControlStyle` presets `.default`, `.accent`), `SkeletonView` + `.skeleton(isLoading:style:)` shimmer modifier (`SkeletonStyle` presets `.default`, `.rounded`), `DividerAtom` (horizontal/vertical, `DividerStyle` presets `.default`, `.inset`).
- **`Toast`** molecule (renamed from `Popup`) with a new `.toast(isPresented:autoDismissAfter:bottomPadding:content:)` presentation modifier (slide+fade, drag-to-dismiss, optional auto-dismiss).
- `TabbarStyle` (+ `.default` preset) and badge support (`badgeCount`) for `TabbarView`; explicit `tabs:` array to show a dynamic subset of tabs.
- `CardStyle.material` and `CardStyle.expandsHorizontally` tokens; `BannerStyle` font tokens (`titleFont`, `subtitleFont`, `actionFont`); `LoadingStateViewStyle.expands` for inline (non-greedy) loading indicators; `LockScreenViewStyle.usesMaterialBackground` and `textSpacing`; `ProgressBarStyle.segmented` preset.
- `ViewState` accessors (`isLoading`, `isEmpty`, `value`, `error`) and conditional `Sendable`.
- `ShareSheet`: `excludedActivityTypes` and completion handler; `Haptics`: `.soft`/`.rigid` impact styles, `Sendable`/`CaseIterable` conformances.
- `scrollDrivenNavigationBarTitleTracking()` — companion modifier that makes the scroll-driven title work on iOS 17 (attach to the scroll *content*).
- `LocalizedStringResource.verbatim(_:)` preview helper (DEBUG only): preview copy no longer pollutes the string catalog.
- Minimum 44pt tap targets (`minTapTarget` token) and `@ScaledMetric` scaling on `CheckboxAtom`, `RadioButtonAtom`, `SwitchAtom`.
- Accessibility: labels/values localized through `Bundle.module`, `.isToggle`/`.isSelected` traits, combined elements on composite views, `accessibilityValue` on progress indicators, Reduce Motion respected by every animation, required `accessibilityLabel` on icon-only `ActionButton`.
- Real test suite (Swift Testing): 18 tests covering hex parsing edge cases, `ViewState` equality, `WeekdayStatusStrip` locale behavior, presets, and construction of every public component.

### Changed (BREAKING)

- **BREAKING:** `Form` → `FormContainer`, `FormStyle` → `FormContainerStyle` (collision with `SwiftUI.Form`/`SwiftUI.FormStyle`).
- **BREAKING:** `Popup` → `Toast`, `PopupStyle` → `ToastStyle`; message is now `LocalizedStringResource`, icon optional, layout metrics style-driven.
- **BREAKING:** `WeeklyTaskCalendar` → `WeekdayStatusStrip`: locale-aware weekday symbols (`Calendar.veryShortWeekdaySymbols` + `firstWeekday`), caller-supplied captions, `Day` gained a public initializer, and the domain-specific `studyDays:`/`nextStudyDay:` initializer was removed.
- **BREAKING:** `Tabbar` protocol → `TabbarItem` (deprecated typealias kept); the modern `Tab`-based branch now activates on iOS 18 instead of iOS 26.
- **BREAKING:** All `previewDefault` presets renamed to `.default` (Checkbox, RadioButton, Switch, TextField, FormLabel, FormHint, FormError, FormItem, FormSection, FormContainer); style parameters now default to `.default` across all form atoms.
- **BREAKING:** `String` text parameters migrated to `LocalizedStringResource`: `Badge`, `Banner`, `FormLabel`, `FormHint`, `FormError`, `FormSection` header/footer, `TextFieldAtom` placeholder, `LockScreenViewContent`, `LabelImage` (was `LocalizedStringKey`).
- **BREAKING:** `ActionButton(systemName:)` now requires an `accessibilityLabel:`; `.primaryCyan` preset renamed to `.tonal` and de-branded to the accent color.
- **BREAKING:** `SelectableItemCardStyle` dropped 7 unused color tokens and gained indicator/spacing tokens; `ListItemCardStyle.courseProgress` renamed to `.prominent`.
- **BREAKING:** `CircularProgressBar` moved `size`/`lineWidth` into `CircularProgressBarStyle`; percentage now rounds instead of truncating.
- **BREAKING:** `bannerAndPopup(hasToShow:backgroundStatusBarStyle:hasTabBar:)` → `bannerAndPopup(hasToShow:backgroundStatusBarStyle:popupBottomPadding:)`; dismissing the toast now writes back to the binding.
- **BREAKING:** `ProgressBarStyle.quizStyle` renamed to `.bold`; presets de-branded from hardcoded cyan to the accent color (also Checkbox/Radio/Switch/TextField/FormLabel `.modern`, `CircularProgressBarStyle.default`, `SelectableItemCardStyle.default`, `WeekdayStatusStripStyle.default`).
- `RadioButtonAtom` is now select-only (tapping a selected radio no longer deselects it — radio-group semantics).
- Lock screen `.default` content is neutral and biometric-agnostic ("Locked"/"Unlock"), localized via the library catalog; default background hides content with a material.
- Deprecated modifiers replaced throughout (`.foregroundColor` → `.foregroundStyle`, `.cornerRadius` → `.clipShape`).

### Fixed

- **Localization actually works**: every library-owned string now resolves against `Bundle.module`; the string catalog was rebuilt with only genuine library keys (preview scaffolding removed).
- `Card` no longer paints a hardcoded material over the injected `backgroundColor`.
- `StatusBarAndPopupModifier`: removed invalid `@State` write in `init` and the one-way binding desync (toast can be re-shown after dismissal).
- Scroll-driven navigation title works on iOS 17 (the old GeometryReader measured the ScrollView itself, so the title never appeared).
- `Banner` no longer renders an empty SF Symbol when no icon is set, and no longer reserves dead space when there is no action content.
- `ErrorState` equality no longer always fails (`id` excluded from `==`).
- `Color(hex:)` returns `nil` on invalid input instead of black; `toHex()` works on macOS.
- `SwitchAtomStyle` presets no longer use UIKit-only color initializers.
- `TextFieldAtomStyle.placeholderColor` is now applied to the prompt; `EmptyStateViewStyle.iconColor`/`ErrorStateViewStyle.iconColor` are now applied to the icon.
- `ProgressBar` indeterminate animation survives view rebuilds (clock-driven via `TimelineView`); `CircularProgressBar` shine arc aligns with the progress arc.
- Carousel paging dots no longer jump to page 1 mid-scroll; scroll-position modifiers no longer change view identity.
- Wrong/incorrect availability annotations removed (`macOS 14` below the declared minimum; `Backport.navigationSubtitle` now gates macOS too).

### Removed (BREAKING)

- **BREAKING:** Dependency on `exyte/PopupView` (and transitively `swiftui-introspect`) — the library is now dependency-free; the bottom toast is implemented natively.
- **BREAKING:** `ActionButtonStyle.removePadding()` (internal dead code).
- Preview fixture types are now `private` and `#if DEBUG`-gated (no more `DemoItem`, `TestTabs`, `DetailView2` in release builds).

## [0.1.x] - 2026-02-21 (previously "Unreleased"; shipped across the 0.1.0–0.1.2 tags)

### Added

- **NEW Form Architecture** – Introduced scalable, composable form components following iOS HIG and modern SwiftUI patterns:
  - `Form` organism – Top-level container for form sections providing consistent spacing and styling
  - `FormSection` molecule – Groups related form items with optional header and footer
  - `FormItem` molecule – Layout container for a single form field (label, input, hint/error) with vertical and horizontal layouts
  - `FormLabel` atom – Text label with optional icon for form fields
  - `FormHint` atom – Helper text for form fields
  - `FormError` atom – Error message text with optional icon
- **NEW State Components** – Introduced reusable state view molecules using iOS 17+ `ContentUnavailableView`:
  - `ErrorStateView` molecule – Displays error states with icon, title, description, and retry button. Style contract: `ErrorStateViewStyle` with presets `.error()`, `.networkError()`, `.serverError()`, `.custom()`.
  - `EmptyStateView` molecule – Displays empty states with icon, title, description, and optional action button. Style contract: `EmptyStateViewStyle` with preset `.empty()`.
  - `LoadingStateView` molecule – Displays loading states with progress indicator (spinner or linear) and optional message. Style contract: `LoadingStateViewStyle` with presets `.default()`, `.minimal()`, `.linear()`, `.custom()`.
- **Localization Support** – All new state components use `LocalizedStringResource` for text parameters, following SwiftUI best practices for SPM packages. Components are fully localizable and ready for multi-language support.
- Style contracts for all new form components: `FormStyle`, `FormSectionStyle`, `FormItemStyle`, `FormLabelStyle`, `FormHintStyle`, `FormErrorStyle`
- Preset styles for all new form components (`.previewDefault`, `.modern`, `.compact` variants where applicable)
- Comprehensive previews demonstrating form composition patterns
- Documented the full beta surface (Carousel, ListItemCard, SelectableItemCard variants, WeeklyTaskCalendar, LockScreenView, Tabbar, and related atoms) and refreshed `README.md`/DocC guidance so the component list now matches the shipped layout and templates.

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

## [0.1.x] - 2026-02-20 (previously "Unreleased"; shipped across the 0.1.0–0.1.2 tags)

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
