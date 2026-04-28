//
//  FreeShippingBannerView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct FreeShippingBannerView: View {
    let qualifies: Bool

    var body: some View {
        Group {
            if qualifies {
                HStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))

                    Text("Your order qualifies for free shipping!")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.green)
                .padding(.horizontal, 18)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.12))
                .cornerRadius(16)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        FreeShippingBannerView(qualifies: true)
        FreeShippingBannerView(qualifies: false)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
