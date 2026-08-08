import Testing
import SwiftUI
@testable import UILibrary

// MARK: - Component construction (smoke)

@Suite("Public API smoke tests") @MainActor
struct PublicAPISmokeTests {

    @Test func atoms_construct() {
        _ = ActionButton(.verbatimForTest("Primary"), style: .primary) {}
        _ = ActionButton(systemName: "trash", accessibilityLabel: .verbatimForTest("Delete"), style: .destructive) {}
        _ = ActionButton(isEnabled: true, style: .primary, action: {}, label: { Text(verbatim: "Add") })
        _ = AvatarImage(name: "Alice")
        _ = AvatarImage(name: "Bob", image: Image(systemName: "person"))
        _ = Badge(.verbatimForTest("New"))
        _ = Card(style: .neutral) { Text(verbatim: "content") }
        _ = CheckboxAtom(isOn: .constant(true))
        _ = RadioButtonAtom(isSelected: .constant(false))
        _ = SwitchAtom(isOn: .constant(true))
        _ = TextFieldAtom(text: .constant(""), placeholder: .verbatimForTest("Type here"))
        _ = ProgressBar(value: 0.5, style: .neutral)
        _ = ProgressBar(style: .accent)
        _ = ProgressBar(currentStep: 1, totalSteps: 3)
        _ = CircularProgressBar(progress: 0.4)
        _ = FormLabel(.verbatimForTest("Label"))
        _ = FormHint(.verbatimForTest("Hint"))
        _ = FormError(.verbatimForTest("Error"))
        _ = LabelImage(.verbatimForTest("Label"), systemImage: "star")
        _ = Chip(.verbatimForTest("Tag"), icon: "tag", isSelected: true, onTap: {}, onRemove: {})
        _ = SegmentedControlAtom(selection: .constant(0), options: [0, 1, 2], title: { _ in .verbatimForTest("Segment") })
        _ = SkeletonView()
        _ = DividerAtom()
        _ = DividerAtom(axis: .vertical, style: .inset)
        _ = DismissToolbarItem(dismiss: {})
    }

    @Test func molecules_and_organisms_construct() {
        _ = Banner(title: .verbatimForTest("Title"), subtitle: .verbatimForTest("Subtitle"), style: .info())
        _ = Toast(icon: "info.circle", message: .verbatimForTest("Test"), style: .neutral)
        _ = EmptyStateView(title: .verbatimForTest("Empty"), description: .verbatimForTest("Nothing here"))
        _ = ErrorStateView(title: .verbatimForTest("Error"), description: .verbatimForTest("Broken"), onRetry: {})
        _ = LoadingStateView(message: .verbatimForTest("Loading"))
        _ = ListItemCard(action: {}) { Text(verbatim: "Row") }
        _ = SelectableItemCard(isSelected: true, action: {}) { Text(verbatim: "Row") }
        _ = WeekdayStatusStrip(statuses: [.completed, .highlighted, .upcoming])
        _ = FormContainer { Text(verbatim: "form") }
        _ = FormSection(header: .verbatimForTest("Header")) { Text(verbatim: "section") }
        _ = FormItem { Text(verbatim: "item") }

        _ = Text(verbatim: "x")
            .backgroundStatusBar(isVisible: true, style: .warning)
            .bannerAndPopup(hasToShow: .constant(true), backgroundStatusBarStyle: .warning) {
                Toast(icon: "wifi.slash", message: .verbatimForTest("Offline"), style: .warning)
            }
            .toast(isPresented: .constant(false)) {
                Toast(message: .verbatimForTest("Saved"))
            }
            .skeleton(isLoading: true)
            .scrollDrivenNavigationBarTitle(.verbatimForTest("Title"), revealAfter: 50)
    }
}

// MARK: - Style presets

@Suite("Style presets") @MainActor
struct StylePresetTests {

    @Test func toastStyle_presets_areDistinct() {
        #expect(ToastStyle.warning != ToastStyle.error)
        #expect(ToastStyle.neutral == ToastStyle(iconColor: .white, textColor: .white, backgroundColor: .gray))
    }

    @Test func backgroundStatusBarStyle_preset() {
        #expect(BackgroundStatusBarStyle.warning == BackgroundStatusBarStyle(backgroundColor: .yellow, height: 60))
    }

    @Test func actionButton_iconCircle_isFullyRounded() {
        let circle = ActionButtonStyle.iconCircle
        #expect(circle.defaultMaxWidth == 44)
        #expect(circle.minTapTarget == CGSize(width: 44, height: 44))
        #expect(circle.borderColor != nil)
        #expect(circle.cornerRadius >= circle.minTapTarget.height / 2)
    }

    @Test func progressBar_presets() {
        let neutral = ProgressBarStyle.neutral
        #expect(neutral.height == 6)
        #expect(neutral.cornerRadius == 3)
        #expect(ProgressBarStyle.accent.progressColor == .accentColor)

        let redVariant = ProgressBarStyle(
            layout: neutral.layout,
            fill: .solid(.red),
            presentation: neutral.presentation,
            track: neutral.track,
            metrics: neutral.metrics
        )
        #expect(neutral != redVariant)
    }

    @Test func avatarImage_presets() {
        let defaultStyle = AvatarImageStyle.default
        #expect(defaultStyle.size == 40)
        #expect(AvatarImageStyle.small.size < defaultStyle.size)

        let bordered = AvatarImageStyle.bordered(.red)
        #expect(bordered.borderColor == .red)
        #expect(bordered.borderWidth == 2)
    }

    @Test func card_neutral_usesMaterial() {
        #expect(CardStyle.neutral.material == .ultraThin)
        #expect(CardStyle.neutral.backgroundColor == nil)
        #expect(CardStyle.surface.backgroundColor != nil)
    }

    @Test func toggleAtomStyles_defaultTapTarget() {
        #expect(CheckboxStyle.default.minTapTarget == 44)
        #expect(RadioButtonStyle.default.minTapTarget == 44)
        #expect(SwitchAtomStyle.default.minTapTarget == 44)
    }
}

// MARK: - Color+Hex

@Suite("Color hex parsing")
struct ColorHexTests {

    @Test func parses_valid_formats() {
        #expect(Color(hex: "FF0000") != nil)
        #expect(Color(hex: "#FF0000") != nil)
        #expect(Color(hex: "F00") != nil)
        #expect(Color(hex: "80FF0000") != nil)
    }

    @Test func rejects_invalid_input() {
        #expect(Color(hex: "ZZZZZZ") == nil)
        #expect(Color(hex: "12345") == nil)
        #expect(Color(hex: "") == nil)
        #expect(Color(hex: "GG00FF") == nil)
        #expect(Color(hex: "FF00ZZ") == nil)
    }

    @Test func red_roundtrips_to_hex() {
        let color = Color(hex: "FF0000")
        #expect(color?.toHex() == "#FF0000")
    }
}

// MARK: - ViewState

@Suite("ViewState")
struct ViewStateTests {

    @Test func errorState_equality_ignores_id() {
        let a = ErrorState(message: "boom")
        let b = ErrorState(message: "boom")
        #expect(a == b)
        #expect(a.id != b.id)
        #expect(ViewState<Int>.error(a) == ViewState<Int>.error(b))
    }

    @Test func accessors() {
        #expect(ViewState.success(1).isSuccess)
        #expect(ViewState.success(2).value == 2)
        #expect(ViewState<Int>.loading.isLoading)
        #expect(ViewState<Int>.empty.isEmpty)
        #expect(ViewState<Int>.error(.init(message: "x")).error?.message == "x")
        #expect(ViewState<Int>.loading.value == nil)
    }
}

// MARK: - WeekdayStatusStrip

@Suite("WeekdayStatusStrip") @MainActor
struct WeekdayStatusStripTests {

    private func calendar(firstWeekday: Int) -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US")
        calendar.firstWeekday = firstWeekday
        return calendar
    }

    @Test func mondayFirst_locales_start_with_monday() {
        let strip = WeekdayStatusStrip(
            statuses: Array(repeating: .upcoming, count: 7),
            calendar: calendar(firstWeekday: 2)
        )
        // en_US very-short symbols are S M T W T F S (Sunday-first)
        #expect(strip.days.map(\.label) == ["M", "T", "W", "T", "F", "S", "S"])
    }

    @Test func sundayFirst_locales_start_with_sunday() {
        let strip = WeekdayStatusStrip(
            statuses: Array(repeating: .upcoming, count: 7),
            calendar: calendar(firstWeekday: 1)
        )
        #expect(strip.days.map(\.label) == ["S", "M", "T", "W", "T", "F", "S"])
    }

    @Test func statuses_map_in_order_and_pad_with_upcoming() {
        let strip = WeekdayStatusStrip(
            statuses: [.completed, .highlighted],
            calendar: calendar(firstWeekday: 2)
        )
        #expect(strip.days.count == 7)
        #expect(strip.days[0].status == .completed)
        #expect(strip.days[1].status == .highlighted)
        #expect(strip.days[2].status == .upcoming)
        #expect(strip.days[6].status == .upcoming)
    }

    @Test func captions_attach_to_matching_status() {
        let strip = WeekdayStatusStrip(
            statuses: [.completed, .upcoming],
            captions: [.completed: .verbatimForTest("Done")],
            calendar: calendar(firstWeekday: 2)
        )
        #expect(strip.days[0].caption != nil)
        #expect(strip.days[1].caption == nil)
    }
}

// MARK: - Helpers

private extension LocalizedStringResource {
    /// Test-only equivalent of the DEBUG preview helper: wraps a raw string
    /// without registering a localization key.
    static func verbatimForTest(_ string: String) -> LocalizedStringResource {
        LocalizedStringResource("\(string)")
    }
}
