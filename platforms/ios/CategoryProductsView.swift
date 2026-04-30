import SwiftUI

struct CategoryProductsView: View {
    @EnvironmentObject var appState: AppState

    let category: Category

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    // 🔁 Selected product → detail screen
    private var selectedProduct: Product? {
        guard let id = appState.selectedProductId else {
            return nil
        }

        return appState.products.first { $0.id == id }
    }

    // 🔁 Products for this category
    private var products: [Product] {
        appState.products.filter { $0.categoryId == category.id }
    }

    var body: some View {
        if let selectedProduct {
            ProductDetailView(
                product: selectedProduct,
                onClose: {
                    appState.closeProductDetail()
                },
                onAddToCart: {
                    appState.addProductToCart(id: selectedProduct.id)
                }
            )
        } else {
            categoryContent
        }
    }

    // 📦 Main category screen
    private var categoryContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {

                // 🔙 Header
                HStack {
                    Button {
                        appState.clearSelectedCategory() // ✅ FIXED
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                    }
                    .buttonStyle(.plain)

                    Text(category.name)
                        .font(.largeTitle.bold())

                    Spacer()
                }

                // 🛍 Product grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(products, id: \.id) { product in
                        Button {
                            appState.selectProduct(id: product.id)
                        } label: {
                            ProductCardView(
                                product: product,
                                onAddToCart: {
                                    appState.addProductToCart(id: product.id)
                                }
                            )
                        }
                        .buttonStyle(.plain)
                    }
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
    CategoryProductsView(
        category: Category(
            id: "jackets",
            name: "Jackets",
            icon: "tshirt"
        )
    )
    .environmentObject(AppState())
}
