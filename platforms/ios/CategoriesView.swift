//
//  CategoriesView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var appState: AppState

    private var selectedCategory: Category? {
        guard let id = appState.selectedCategoryId else {
            return nil
        }

        return appState.categories.first { $0.id == id }
    }

    var body: some View {
        if let selectedCategory {
            CategoryProductsView(category: selectedCategory)
        } else {
            categoryList
        }
    }

    private var categoryList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Text("Categories")
                    .font(.largeTitle.bold())

                ForEach(appState.categories, id: \.id) { category in
                    Button {
                        appState.selectCategory(id: category.id)
                    } label: {
                        CategoryRowView(category: category)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)
            .padding(.bottom, 18)
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    CategoriesView()
        .environmentObject(AppState())
}
