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
}
