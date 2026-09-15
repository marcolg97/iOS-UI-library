# Journal

## 2026-09-15 — Per-item accessibility identifiers on `SegmentedControlAtom`

Driven by a consuming app (PartyPlanner) rebuild that hit the same blocker in two places: the
library's selection controls gave callers no way to attach a per-item accessibility identifier, so
XCUITest couldn't address individual segments/options and the app had to fall back to native
`Picker(.segmented)` plus a hand-rolled chip row instead of library components.

- **Surveyed the gap.** `SegmentedControlAtom` takes `options: [Option]` + a `title: (Option) ->
  LocalizedStringResource` closure and renders each segment internally via `ForEach` — the caller
  never gets a handle to the individual segment view, so it had no way to attach an identifier per
  option. `RadioButtonAtom`, `CheckboxAtom`, and `Chip` don't have this problem: apps instantiate
  one of these per item themselves (typically inside their own `ForEach`), so `.accessibilityIdentifier(_:)`
  already works today by applying it directly to each instance — no library change needed there.
- **`SegmentedControlAtom(accessibilityIdentifier:)`**: new optional `(Option) -> String?` closure,
  mirroring the existing `title` closure's shape and the placement convention used elsewhere in the
  library (`QuantityStepper.accessibilityLabel` sits right after the parameter it describes).
  Defaults to `nil` — every existing call site keeps compiling unchanged. The identifier is applied
  to the segment's own `Button` (the leaf, via the existing `.if(_:transform:)` modifier), never to
  the surrounding `HStack` container, since an identifier on a container overrides its children and
  makes them unaddressable to XCUITest.
- **Selected state was already correct**: each segment already carried `.accessibilityAddTraits(isSelected
  ? [.isButton, .isSelected] : [.isButton])`, so VoiceOver/XCUITest already see the right selected
  state. Nothing changed there.
- Added a preview variant showing a segmented control with per-segment identifiers
  (`"editor.range.week"` etc.) and a construction smoke test exercising the new parameter, matching
  how other additive, non-computational changes in this library are tested (no new pure function to
  extract here — the change is a straight closure pass-through, unlike e.g. `titleOpacity` or
  `clampedValue`).

Rationale: this is exactly the kind of cross-app UI-testing concern the library exists to
centralize — any screen with a segmented picker needs its segments addressable by UI tests, and the
fix generalizes past the one app that surfaced it.

## 2026-09-14 — Scroll-driven title fix, QuantityStepper, Badge.dot, adaptive form layout

Driven by a UI audit of a consuming app (Chi Porta Cosa) that found the scroll-driven nav title bug affecting ~7 screens, plus four small library additions the app needed.

- **Fixed `scrollDrivenNavigationBarTitle` on non-scrolling screens**: the modifier compared scroll offset against `revealAfter` unconditionally, so screens whose content never scrolls that far (most of them short/one-page forms) shipped with a permanently invisible nav title. The modifier now measures content height vs. viewport height (iOS 18+ via `ScrollGeometry.contentSize`/`containerSize`; iOS 17 via a second preference key alongside the existing offset one) and shows the title at full opacity immediately when there's nothing to scroll. When there is something to scroll, opacity now ramps continuously with offset instead of snapping at the threshold — a smoother, more predictable fade. The opacity math is a pure `nonisolated static func titleOpacity(scrollOffset:contentHeight:viewportHeight:threshold:)`, unit-tested directly (7 tests: not-scrollable, at-top, past-threshold, intermediate ramp, negative-offset clamping, zero-threshold edge case).
- **`QuantityStepper` atom**: compact `−`/`+` stepper for small integer quantities (portions, party size, cart quantity). Built on `ActionButton.iconCircle` so it inherits the 44pt tap target for free. Exposed to VoiceOver as one adjustable element (`accessibilityAdjustableAction`) rather than two separately-focusable buttons — mirrors how SwiftUI's own `Stepper` behaves. Stepping arithmetic is a pure `clampedValue(_:step:range:direction:)` for deterministic testing.
- **`Badge.dot(accessibilityLabel:style:)`**: extended `Badge`/`BadgeStyle` (rather than adding a parallel type) with an optional `dotDiameter` token; when set, `Badge` renders a plain filled circle instead of its text pill, using the passed text purely as the VoiceOver label. Replaces call sites that were bypassing `Badge` entirely to draw a raw `Circle()` for a status dot.
- **`FormItemLayout.adaptive`**: a third case alongside `.vertical`/`.horizontal` that resolves to `.vertical` once `dynamicTypeSize.isAccessibilitySize` is true and `.horizontal` otherwise — solves the "label/value row gets squeezed at accessibility XL" problem once in `FormItem` instead of every call site re-deriving it with `AnyLayout`.
- **`CardStyle` docc**: documented (no API change) that `backgroundColor` and `material` are mutually exclusive in practice — `Card` draws `backgroundColor` on top of `material`, so an opaque color fully hides the material underneath.

**Deviations from the source proposal:**
- The proposal sketched `QuantityStepper.init(value:range:style:)` with no accessibility parameter; added a required `accessibilityLabel: LocalizedStringResource` instead, mirroring `ActionButton`'s icon-only initializer — a bare number has no meaning to VoiceOver without one.
- The proposal put the dot preset only on `BadgeStyle` (`static func dot(_:) -> BadgeStyle`); also added `Badge.dot(accessibilityLabel:style:)` as the actual construction entry point, since `Badge`'s existing contract treats its `text` parameter as the accessibility label — a dot has no visible text to supply that role on its own.

Rationale: all four changes are exactly the kind of generic, cross-app UI concern this library exists to centralize (any list+claim/booking/cart flow needs a quantity stepper; any status list needs a lightweight dot indicator; any form needs to survive accessibility Dynamic Type; any scroll screen can be short). Nothing here encodes app-specific domain concepts.

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
