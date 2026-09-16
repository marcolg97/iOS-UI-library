//
//  GoogleSignInButton.swift
//  UILibrary
//

import SwiftUI

/// A "Sign in with Google" button drawn by us, using Google's real multicolour "G" logo.
///
/// Why not Google's own SwiftUI button: `GoogleSignInSwift`'s `GoogleSignInButton` hardcodes its
/// corner radius (2pt) and height (40pt) as internal constants with no public override, so it can
/// never match an app whose other buttons are pills — it always reads as a foreign object in the
/// stack.
///
/// Why this is still compliant: Google's branding guidelines
/// (developers.google.com/identity/branding-guidelines) permit a custom button "to adapt the
/// button to match your app design", provided the logo keeps its standard shape and colours and
/// the label is one of their recommended call-to-action strings. Both hold here — the logo is the
/// asset vendored from Google's own SDK resource bundle, drawn unmodified, and the default label
/// is "Sign in with Google".
///
/// The shape comes from the `ActionButtonStyle` you pass, so the button inherits the host app's
/// button geometry; only the colours, logo and label are Google's.
public struct GoogleSignInButton: View {
    private let title: LocalizedStringResource?
    private let isEnabled: Bool
    private let style: GoogleSignInButtonStyle
    private let buttonStyle: ActionButtonStyle
    private let action: () -> Void

    public init(
        title: LocalizedStringResource? = nil,
        isEnabled: Bool = true,
        style: GoogleSignInButtonStyle = .light,
        buttonStyle: ActionButtonStyle,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.style = style
        self.buttonStyle = buttonStyle
        self.action = action
    }

    public var body: some View {
        ActionButton(isEnabled: isEnabled, style: buttonStyle, action: action) {
            HStack(spacing: style.spacing) {
                Image("GoogleLogo", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: style.logoSize, height: style.logoSize)
                    .accessibilityHidden(true)

                if let title {
                    Text(title)
                } else {
                    Text("Sign in with Google", bundle: .module)
                }
            }
        }
    }
}

#Preview("Google sign-in button") {
    VStack(spacing: 16) {
        GoogleSignInButton(style: .light, buttonStyle: .secondary, action: {})
        GoogleSignInButton(isEnabled: false, style: .light, buttonStyle: .secondary, action: {})
    }
    .padding()
}
