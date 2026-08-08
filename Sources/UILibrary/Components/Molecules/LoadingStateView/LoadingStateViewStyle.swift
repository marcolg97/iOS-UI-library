//
//  LoadingStateViewStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 23/02/26.
//

import SwiftUI

/// Style contract for `LoadingStateView`.
///
/// Describes visual tokens used by `LoadingStateView` (progress indicator, colors, fonts, spacing).
/// Immutable and brand-agnostic.
public struct LoadingStateViewStyle: Equatable, Sendable {
    /// Style of the progress indicator (spinner or linear).
    public let progressStyle: LoadingProgressStyle
    
    /// Color for the progress indicator.
    public let progressColor: Color
    
    /// Scale factor for the progress indicator.
    public let progressScale: CGFloat
    
    /// Control size for the progress indicator.
    public let controlSize: ControlSize
    
    /// Color for the message text.
    public let messageColor: Color
    
    /// Font for the message text.
    public let messageFont: Font
    
    /// Spacing between progress indicator and message.
    public let spacing: CGFloat
    
    /// Padding around the loading view.
    public let padding: CGFloat
    
    /// Width of the linear progress bar (only used when progressStyle is .linear).
    public let linearProgressWidth: CGFloat

    /// Whether the view greedily fills the available space (full-screen
    /// loading) or hugs its content (inline loading).
    public let expands: Bool

    /// Creates a `LoadingStateViewStyle`.
    /// - Parameters:
    ///   - progressStyle: Style of progress indicator (default: .spinner).
    ///   - progressColor: Color for the progress indicator (default: .accentColor).
    ///   - progressScale: Scale factor for the progress indicator (default: 1.0).
    ///   - controlSize: Control size for the progress indicator (default: .regular).
    ///   - messageColor: Color for the message text (default: .secondary).
    ///   - messageFont: Font for the message text (default: .body).
    ///   - spacing: Spacing between indicator and message (default: 16).
    ///   - padding: Padding around the loading view (default: 20).
    ///   - linearProgressWidth: Width of linear progress bar (default: 200).
    ///   - expands: Whether the view fills the available space (default: true).
    public init(
        progressStyle: LoadingProgressStyle = .spinner,
        progressColor: Color = .accentColor,
        progressScale: CGFloat = 1.0,
        controlSize: ControlSize = .regular,
        messageColor: Color = .secondary,
        messageFont: Font = .body,
        spacing: CGFloat = 16,
        padding: CGFloat = 20,
        linearProgressWidth: CGFloat = 200,
        expands: Bool = true
    ) {
        self.progressStyle = progressStyle
        self.progressColor = progressColor
        self.progressScale = progressScale
        self.controlSize = controlSize
        self.messageColor = messageColor
        self.messageFont = messageFont
        self.spacing = spacing
        self.padding = padding
        self.linearProgressWidth = linearProgressWidth
        self.expands = expands
    }
}
