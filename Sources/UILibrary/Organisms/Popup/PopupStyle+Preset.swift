//
//  PopupStyle+Preset.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

/// Common, branded-agnostic `PopupStyle` presets used by apps/design systems for quick usage.
public extension PopupStyle {
    /// Warning style (yellow background).
    static let warning = PopupStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .yellow
    )
    
    /// Error style (red background).
    static let error = PopupStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .red
    )
    
    /// Success style (green background).
    static let success = PopupStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .green
    )
    
    /// Neutral/default style (gray background).
    static let neutral = PopupStyle(
        iconColor: .white,
        textColor: .white,
        backgroundColor: .gray
    )
}
