//
//  DismissToolbarItem.swift
//  DesignSystem
//
//  Created by Marco La Gala on 09/02/26.
//

import SwiftUI

public struct DismissToolbarItem: ToolbarContent {
    private let dismiss: () -> Void

    public init(dismiss: @escaping () -> Void) {
        self.dismiss = dismiss
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
}
