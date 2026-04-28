//
//  CheckoutButtonView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct CheckoutButtonView: View {
    let onCheckout: () -> Void

    var body: some View {
        Button {
            onCheckout()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "lock")
                Text("Proceed to Checkout")
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(Color.blue)
            .cornerRadius(32)
            .shadow(color: Color.blue.opacity(0.28), radius: 10, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .padding(.top, 6)
        .padding(.bottom, 4)
    }
}

#Preview {
    CheckoutButtonView {
        print("Checkout tapped")
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
