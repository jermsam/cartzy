//
//  OrderSummaryView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct OrderSummaryView: View {
    let summary: CartSummary?

    var body: some View {
        Group {
            if let summary {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Order Summary")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 4)

                    SummaryRowView(
                        title: "Subtotal (\(summary.itemCount) items)",
                        value: formatMoney(summary.subtotalCents)
                    )

                    SummaryRowView(
                        title: "Shipping",
                        value: summary.shippingCents == 0
                            ? "FREE"
                            : formatMoney(summary.shippingCents),
                        valueColor: summary.shippingCents == 0 ? .green : .primary,
                        valueBold: summary.shippingCents == 0
                    )

                    SummaryRowView(
                        title: "Tax",
                        value: formatMoney(summary.taxCents)
                    )

                    Divider()
                        .padding(.vertical, 4)

                    SummaryRowView(
                        title: "Total",
                        value: formatMoney(summary.totalCents),
                        bold: true
                    )
                }
                .padding(18)
                .background(Color(.systemBackground))
                .cornerRadius(18)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
            }
        }
    }
}

struct SummaryRowView: View {
    let title: String
    let value: String
    var bold: Bool = false
    var valueColor: Color = .primary
    var valueBold: Bool = false

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .foregroundColor(valueColor)
                .fontWeight(valueBold ? .bold : .regular)
        }
        .font(bold ? .system(size: 18, weight: .bold) : .system(size: 16))
    }
}

#Preview {
    OrderSummaryView(
        summary: CartSummary(
            itemCount: 3,
            subtotalCents: 19997,
            shippingCents: 0,
            taxCents: 1599,
            totalCents: 21596,
            qualifiesForFreeShipping: true
        )
    )
    .padding()
    .background(Color(.systemGroupedBackground))
    .previewLayout(.sizeThatFits)
}
