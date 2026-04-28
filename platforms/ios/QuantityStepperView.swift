//
//  QuantityStepperView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct QuantityStepperView: View {
    let quantity: UInt32
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button("−") {
                withAnimation {
                    onDecrement()
                }
            }

            Text("\(quantity)")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.primary)
                .frame(width: 22)

            Button("+") {
                withAnimation {
                    onIncrement()
                }
            }
        }
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.blue)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(22)
    }
}

#Preview {
    VStack(spacing: 20) {
        QuantityStepperView(
            quantity: 1,
            onIncrement: {},
            onDecrement: {}
        )

        QuantityStepperView(
            quantity: 9,
            onIncrement: {},
            onDecrement: {}
        )
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
