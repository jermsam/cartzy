//
//  CategoryChipView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct CategoryChipView: View {
    let category: Category
    let selected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: category.icon)
                Text(category.name)
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(selected ? .white : .primary)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(selected ? Color.blue : Color(.systemBackground))
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        CategoryChipView(
            category: Category(id: "shoes", name: "Shoes", icon: "shoeprints.fill"),
            selected: true,
            onTap: {}
        )

        CategoryChipView(
            category: Category(id: "bags", name: "Bags", icon: "bag.fill"),
            selected: false,
            onTap: {}
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
