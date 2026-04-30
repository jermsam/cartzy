import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    // 🔁 Category filtering
    private var visibleProducts: [Product] {
        guard let selected = appState.selectedHomeCategoryId else {
            return appState.products
        }

        return appState.products.filter { $0.categoryId == selected }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {

                // 🔝 Title
                Text("Featured")
                    .font(.largeTitle.bold())

                // 🧩 Category chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {

                        // "All"
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

                        // Categories
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
                            appState.openProductDetail(id: product.id) // ✅ NavigationStack push
                        } label: {
                            ProductCardView(
                                product: product,
                                isFavorite: appState.isFavorite(id: product.id),
                                onToggleFavorite: {
                                    appState.toggleFavorite(id: product.id)
                                },
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
