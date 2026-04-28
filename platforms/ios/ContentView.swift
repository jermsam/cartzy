import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
//                    header
                    CartHeaderView(
                        itemCount: appState.summary?.itemCount ?? 0
                    )
//                    freeShippingBanner
                    FreeShippingBannerView(
                        qualifies: appState.summary?.qualifiesForFreeShipping == true
                    )
//                    cartItems
                    ForEach(appState.items, id: \.id) { item in
                        CartItemRowView(
                            item: item,
                            onIncrement: { appState.incrementItem(id: item.id) },
                            onDecrement: { appState.decrementItem(id: item.id) },
                            onRemove: { appState.removeItem(id: item.id) }
                        )
                    }
//                    orderSummary
                    OrderSummaryView(summary: appState.summary)
//                    checkoutButton
                    CheckoutButtonView {
                        // TODO: checkout
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .padding(.bottom, 18)
            }
            .background(Color(.systemGroupedBackground))

//            bottomMenu
            BottomMenuView(
                itemCount: appState.summary?.itemCount ?? 0
            )
        }
        .background(Color(.systemGroupedBackground))
    }

//    private var header: some View {
//        CartHeaderView(
//            itemCount: appState.summary?.itemCount ?? 0
//        )
//    }

//    private var freeShippingBanner: some View {
//        FreeShippingBannerView(
//            qualifies: appState.summary?.qualifiesForFreeShipping == true
//        )
//    }

//    private var cartItems: some View {
//        ForEach(appState.items, id: \.id) { item in
//            CartItemRowView(
//                item: item,
//                onIncrement: { appState.increment(item) },
//                onDecrement: { appState.decrement(item) },
//                onRemove: { appState.remove(item) }
//            )
//        }
//    }

//    private var orderSummary: some View {
//        OrderSummaryView(summary: appState.summary)
//    }

//    private var checkoutButton: some View {
//        CheckoutButtonView {
//            // TODO: checkout
//        }
//    }

//    private var bottomMenu: some View {
//        BottomMenuView(
//            itemCount: appState.summary?.itemCount ?? 0
//        )
//    }


}


#Preview {
    ContentView()
        .environmentObject(AppState())
}
