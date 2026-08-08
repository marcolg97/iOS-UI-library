//
//  ViewState.swift
//  UILibrary
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

extension ViewState: Sendable where T: Sendable {}

public extension ViewState {
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var isEmpty: Bool {
        if case .empty = self { return true }
        return false
    }

    /// The wrapped value when the state is `.success`, `nil` otherwise.
    var value: T? {
        if case .success(let value) = self { return value }
        return nil
    }

    /// The error details when the state is `.error`, `nil` otherwise.
    var error: ErrorState? {
        if case .error(let error) = self { return error }
        return nil
    }
}

/// Wraps error information in a safe and Equatable way.
///
/// `id` is unique per instance (useful to re-trigger alerts for repeated errors)
/// and is intentionally excluded from equality: two `ErrorState`s are equal
/// when their `message` matches.
public struct ErrorState: Equatable, Identifiable, Sendable {
    public let id = UUID()
    public let message: String

    public init(message: String) {
        self.message = message
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.message == rhs.message
    }
}
