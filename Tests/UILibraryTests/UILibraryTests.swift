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
            .bannerAndPopup(isOffline: Binding.constant(true), backgroundStatusBarStyle: BackgroundStatusBarStyle.warning, hasTabbar: false) {
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
        let modifier = StatusBarAndPopupModifier(isOffline: binding, backgroundStatusBarStyle: .warning, hasTabbar: false) {
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
        _ = ActionButton(isEnabled: true, style: .primary) { HStack { Image(systemName: "plus"); Text("Add") } } action: { }

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
}
