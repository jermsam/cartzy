//
//  CartItemRowView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct CartItemRowView: View {
    let item: CartItemView
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ProductImageView(url: item.imageUrl)

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.name)
                            .font(.system(size: 17, weight: .bold))
                            .lineLimit(2)

                        Text(detailsText)
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Button {
                        withAnimation {
                            onRemove()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                }

                HStack {
                    Text(formatMoney(item.priceCents))
                        .font(.system(size: 18, weight: .bold))

                    Spacer()

                    QuantityStepperView(
                        quantity: item.quantity,
                        onIncrement: onIncrement,
                        onDecrement: onDecrement
                    )
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
    }

    private var detailsText: String {
        if let size = item.size {
            return "Size: \(size) • Color: \(item.color)"
        } else {
            return "Color: \(item.color)"
        }
    }
}

#Preview {
    CartItemRowView(
        item: CartItemView(
            id: "sneakers",
            name: "Classic White Sneakers",
            imageUrl: "https://cdn.packhacker.com/2022/04/2126e354-lululemon-everyday-backpack-2.0-23l.jpg",
            size: "9",
            color: "White",
            priceCents: 5999,
            quantity: 1,
            lineTotalCents: 5999
        ),
        onIncrement: {},
        onDecrement: {},
        onRemove: {}
    )
    .padding()
    .background(Color(.systemGroupedBackground))
    .previewLayout(.sizeThatFits)
}
