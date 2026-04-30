import SwiftUI

struct CategoryProductsView: View {
    @EnvironmentObject var appState: AppState

    let category: Category

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    private var products: [Product] {
        appState.products.filter { $0.categoryId == category.id }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Text(category.name)
                    .font(.largeTitle.bold())

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(products, id: \.id) { product in
                        Button {
                            appState.openProductDetail(id: product.id)
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
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CategoryProductsView(
            category: Category(
                id: "jackets",
                name: "Jackets",
                icon: "tshirt"
            )
        )
        .environmentObject(AppState())
    }
}
