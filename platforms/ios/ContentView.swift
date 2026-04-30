import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack(path: $appState.path) {
                VStack(spacing: 0) {
                    Group {
                        switch appState.selectedTab {
                        case .home:
                            HomeView()

                        case .categories:
                            CategoriesView()

                        case .cart:
                            cartScreen

                        case .profile:
                            ProfileView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    BottomMenuView(
                        selectedTab: appState.selectedTab,
                        itemCount: appState.summary?.itemCount ?? 0,
                        onSelect: { tab in
                            appState.resetNavigation()
                            appState.selectTab(tab)
                        }
                    )
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .productDetail(let productId):
                        ProductDetailRouteView(productId: productId)

                    case .categoryProducts(let categoryId):
                        CategoryProductsRouteView(categoryId: categoryId)
                    }
                }
            }

            if let message = appState.toastMessage {
                ToastView(message: message)
                    .padding(.bottom, 90)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(), value: appState.toastMessage)
        .background(Color(.systemGroupedBackground))
    }

    // 🛒 Cart screen (unchanged)
    private var cartScreen: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 14) {

                CartHeaderView(
                    itemCount: appState.summary?.itemCount ?? 0
                )

                FreeShippingBannerView(
                    qualifies: appState.summary?.qualifiesForFreeShipping == true
                )

                ForEach(appState.items, id: \.id) { item in
                    CartItemRowView(
                        item: item,
                        onIncrement: { appState.incrementItem(id: item.id) },
                        onDecrement: { appState.decrementItem(id: item.id) },
                        onRemove: { appState.removeItem(id: item.id) }
                    )
                }

                OrderSummaryView(summary: appState.summary)

                CheckoutButtonView {
                    // TODO: checkout
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
    ContentView()
        .environmentObject(AppState())
}
