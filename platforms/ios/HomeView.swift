import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

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

    // 🔁 Category filtering
    private var visibleProducts: [Product] {
        guard let selected = appState.selectedHomeCategoryId else {
            return appState.products
        }

        return appState.products.filter { $0.categoryId == selected }
    }

    var body: some View {
        // 👉 Navigation switch
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
            homeContent
        }
    }

    // 🏠 Main home content
    private var homeContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {

                // 🔝 Title
                Text("Featured")
                    .font(.largeTitle.bold())

                // 🧩 Category chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {

                        // "All" chip
                        Button {
                            appState.selectHomeCategory(id: nil)
                        } label: {
                            Text("All")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(
                                    appState.selectedHomeCategoryId == nil
                                    ? .white
                                    : .primary
                                )
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    appState.selectedHomeCategoryId == nil
                                    ? Color.blue
                                    : Color(.systemBackground)
                                )
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)

                        // category chips
                        ForEach(appState.categories, id: \.id) { category in
                            CategoryChipView(
                                category: category,
                                selected: appState.selectedHomeCategoryId == category.id,
                                onTap: {
                                    appState.selectHomeCategory(id: category.id)
                                }
                            )
                        }
                    }
                }

                // 🛍 Product grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(visibleProducts, id: \.id) { product in
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
    HomeView()
        .environmentObject(AppState())
}
