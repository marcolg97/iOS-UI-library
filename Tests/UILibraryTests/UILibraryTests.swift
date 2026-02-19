import Testing
import XCTest
import SwiftUI
import UILibrary

@Suite @MainActor
struct MockTest {
    
    @Test func publicAPI_compile() async throws {
        // compile-time smoke test for public API surface
        _ = Popup(icon: "info.circle", message: "Test", style: PopupStyle.neutral)
        _ = PopupStyle(iconColor: .white, textColor: .white, backgroundColor: .gray)
        _ = BackgroundStatusBarStyle(backgroundColor: .yellow, height: 60)
        
        // ensure modifiers are available
        let _ = Text("x")
            .backgroundStatusBar(isVisible: true, style: BackgroundStatusBarStyle.warning)
            .bannerAndPopup(hasToShow: Binding.constant(true), backgroundStatusBarStyle: BackgroundStatusBarStyle.warning, hasTabBar: false) {
                Popup(icon: "wifi.slash", message: "m", style: PopupStyle.warning)
            }
    }
    
    @Test func popupStyle_presets_areDistinct() throws {
        XCTAssertNotEqual(PopupStyle.warning, PopupStyle.error)
        XCTAssertEqual(PopupStyle.neutral, PopupStyle(iconColor: .white, textColor: .white, backgroundColor: .gray))
    }
    
    @Test func backgroundStatusBarStyle_preset() throws {
        XCTAssertEqual(BackgroundStatusBarStyle.warning, BackgroundStatusBarStyle(backgroundColor: .yellow, height: 60))
    }
    
    @Test func statusBarAndPopupModifier_binding_passthrough() throws {
        var offline = true
        let binding = Binding(get: { offline }, set: { offline = $0 })
        let modifier = StatusBarAndPopupModifier(hasToShow: binding, backgroundStatusBarStyle: .warning, hasTabBar: false) {
            Popup(icon: "wifi.slash", message: "m", style: PopupStyle.warning)
        }
        
        XCTAssertTrue(modifier.hasToShow)
        offline = false
        XCTAssertFalse(modifier.hasToShow)
    }

    @Test func actionButton_api_compile_and_style_checks() throws {
        // compile-time smoke: text, icon-only, custom content
        _ = ActionButton("Primary", style: .primary) {}
        _ = ActionButton(systemName: "trash", style: .destructive) {}
        _ = ActionButton(isEnabled: true, style: .primary, action: {}, label:  { HStack { Image(systemName: "plus"); Text("Add") } })

        // style sanity checks
        let cyan = ActionButtonStyle.primaryCyan
        XCTAssertEqual(cyan.cornerRadius, 16)
        XCTAssertEqual(cyan.shadowRadius, 10)
        XCTAssertEqual(cyan.defaultMaxWidth, .infinity)

        // circular icon button style
        let circle = ActionButtonStyle.iconCircle
        XCTAssertEqual(circle.defaultMaxWidth, 44)
        XCTAssertEqual(circle.minTapTarget, CGSize(width: 44, height: 44))
        XCTAssertNotNil(circle.borderColor)
        XCTAssertGreaterThanOrEqual(circle.cornerRadius, circle.minTapTarget.height / 2)
    }

    @Test func progressBar_api_compile_and_style_checks() throws {
        // compile-time smoke: determinate, indeterminate and segmented
        _ = ProgressBar(value: 0.5, style: .neutral)
        _ = ProgressBar(style: .accent)
        _ = ProgressBar(currentStep: 1, totalSteps: 3)

        // style presets
        let neutral = ProgressBarStyle.neutral
        XCTAssertEqual(neutral.height, 6)
        XCTAssertEqual(neutral.cornerRadius, 3)

        let accent = ProgressBarStyle.accent
        XCTAssertEqual(accent.progressColor, .accentColor)
    }

    @Test func progressBar_style_presets_areDistinct() throws {
        XCTAssertEqual(ProgressBarStyle.neutral, ProgressBarStyle())
        XCTAssertNotEqual(ProgressBarStyle.neutral, ProgressBarStyle(progressColor: .red))
    }
}
