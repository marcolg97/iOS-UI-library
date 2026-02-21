//
//  ShareSheet.swift
//  CleanExpenseTracker
//
//  Created by Marco La Gala on 03/02/26.
//

/// Lightweight wrapper around `UIActivityViewController` for sharing from SwiftUI.
#if canImport(UIKit)
import SwiftUI
import UIKit

public struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    var activities: [UIActivity]? = nil

    public init(items: [Any], activities: [UIActivity]? = nil) {
        self.items = items
        self.activities = activities
    }
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: activities)
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
#endif
