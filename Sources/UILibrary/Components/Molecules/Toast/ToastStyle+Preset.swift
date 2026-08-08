//
//  ToastStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

/// Common, brand-agnostic `ToastStyle` presets used by apps/design systems for quick usage.
public extension ToastStyle {
    /// Warning style (yellow background, dark content for contrast).
    static let warning = ToastStyle(
        iconColor: .black,
        textColor: .black,
        backgroundColor: .yellow
    )

    /// Error style (red background).
    static let error = ToastStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .red
    )

    /// Success style (green background).
    static let success = ToastStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .green
    )

    /// Neutral/default style (gray background).
    static let neutral = ToastStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .gray
    )
}
