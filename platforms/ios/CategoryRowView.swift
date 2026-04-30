//
//  CategoryRowView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct CategoryRowView: View {
    let category: Category

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: category.icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.blue)
                .frame(width: 54, height: 54)
                .background(Color.blue.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text(category.name)
                .font(.system(size: 18, weight: .bold))

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    CategoryRowView(
        category: Category(
            id: "shoes",
            name: "Shoes",
            icon: "shoeprints.fill"
        )
    )
    .padding()
    .background(Color(.systemGroupedBackground))
    .previewLayout(.sizeThatFits)
}
