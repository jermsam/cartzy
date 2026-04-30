//
//  CategoryProductsRouteView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct CategoryProductsRouteView: View {
    @EnvironmentObject var appState: AppState

    let categoryId: String

    private var category: Category? {
        appState.categories.first { $0.id == categoryId }
    }

    var body: some View {
        if let category {
            CategoryProductsView(category: category)
        } else {
            Text("Category not found")
        }
    }
}

#Preview {
    CategoryProductsRouteView(categoryId: "jackets")
        .environmentObject(AppState())
}
