//
//  ProductCardSkeletonView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/30/26.
//

import Foundation
import SwiftUI

struct ProductCardSkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ShimmerView()
                .frame(width: 96, height: 96)
                .cornerRadius(14)

            ShimmerView()
                .frame(height: 16)
                .cornerRadius(8)

            ShimmerView()
                .frame(width: 90, height: 14)
                .cornerRadius(8)

            HStack {
                ShimmerView()
                    .frame(width: 70, height: 18)
                    .cornerRadius(8)

                Spacer()

                ShimmerView()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.04), radius: 8, y: 4)
    }
}

#Preview {
    ProductCardSkeletonView()
        .padding()
        .background(Color(.systemGroupedBackground))
}
