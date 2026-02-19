//
//  ViewState.swift
//  CoreUI
//
//  Created by Marco La Gala on 25/09/25.
//

import Foundation

/// Represents a generic SwiftUI view state.
/// - success: contains a value of type `T`.
/// - empty: no data available.
/// - loading: data is being loaded.
/// - error: failure with details.
public enum ViewState<T: Equatable>: Equatable {
    case success(T)
    case empty
    case loading
    case error(ErrorState)
}

public extension ViewState {
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
}

/// Wraps error information in a safe and Equatable way.
public struct ErrorState: Equatable, Identifiable {
    public let id = UUID()
    public let message: String

    public init(message: String) {
        self.message = message
    }
}
