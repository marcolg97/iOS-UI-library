//
//  BackgroundStatusBarStyle.swift
//  UILibrary
//
//  Created by Marco La Gala on 18/02/26.
//

import Foundation
import SwiftUI

/// Style contract for `BackgroundStatusBarView`.
///
/// Describes visual tokens for the top status bar (background color and height). Immutable and brand-agnostic.
public struct BackgroundStatusBarStyle: Equatable, Sendable {
    /// Background color for the status bar.
    public let backgroundColor: Color
    /// Height of the status bar.
    public let height: CGFloat
    
    /// Creates a `BackgroundStatusBarStyle`.
    /// - Parameters:
    ///   - backgroundColor: Background color for the bar.
    ///   - height: Height in points.
    public init(backgroundColor: Color, height: CGFloat) {
        self.backgroundColor = backgroundColor
        self.height = height
    }
}
