//
//  ShareSheet.swift
//  UILibrary
//
//  Created by Marco La Gala on 03/02/26.
//

/// Lightweight wrapper around `UIActivityViewController` for sharing from SwiftUI.
///
/// - Note: iOS/Mac Catalyst only — the type is unavailable on macOS. Prefer
///   SwiftUI's native `ShareLink` when the shared payload conforms to
///   `Transferable`; this wrapper remains useful for heterogeneous item arrays
///   and custom `UIActivity` lists.
#if canImport(UIKit)
import SwiftUI
import UIKit

public struct ShareSheet: UIViewControllerRepresentable {
    public let items: [Any]
    public let activities: [UIActivity]?
    public let excludedActivityTypes: [UIActivity.ActivityType]?
    public let onComplete: UIActivityViewController.CompletionWithItemsHandler?

    public init(
        items: [Any],
        activities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil,
        onComplete: UIActivityViewController.CompletionWithItemsHandler? = nil
    ) {
        self.items = items
        self.activities = activities
        self.excludedActivityTypes = excludedActivityTypes
        self.onComplete = onComplete
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: activities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = onComplete
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
#endif
