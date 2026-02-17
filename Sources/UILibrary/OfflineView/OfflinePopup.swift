//
//  OfflinePopup.swift
//  UILibrary
//
//  Created by Marco La Gala on 17/02/26.
//

import SwiftUI

struct OfflinePopup: View {
    let message: String
    let color: Color?
    
    init(message: String, color: Color?) {
        self.message = message
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "wifi.slash")
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
            
            Text(message)
                .foregroundColor(.white)
                .font(.system(size: 16))
        }
        .padding(16)
        .background(color.cornerRadius(12))
        .padding(.horizontal, 16)
    }
}
