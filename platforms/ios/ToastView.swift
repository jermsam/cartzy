//
//  ToastView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct ToastView: View {
    let message: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
            Text(message)
                .font(.subheadline.bold())
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.82))
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.16), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    ToastView(message: "Added to cart")
        .padding()
        .previewLayout(.sizeThatFits)
}
