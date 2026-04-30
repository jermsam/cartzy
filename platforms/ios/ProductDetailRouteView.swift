//
//  ProductDetailRouteView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct ProductDetailRouteView: View {
    @EnvironmentObject var appState: AppState

    let productId: String

    private var product: Product? {
        appState.products.first { $0.id == productId }
    }

    var body: some View {
        if let product {
            ProductDetailView(
                product: product,
                onClose: {
                    appState.goBack()
                },
                onAddToCart: {
                    appState.addProductToCart(id: product.id)
                }
            )
        } else {
            Text("Product not found")
        }
    }
}

#Preview {
    ProductDetailRouteView(productId: "sneakers")
        .environmentObject(AppState())
}
