import SwiftUI

@MainActor
class AppState: ObservableObject {
    // 👇 ADD THESE
//    @Published var items: [CartItemView] = []
//    @Published var summary: CartSummary?
      @Published private(set) var items: [CartItemView] = []
      @Published private(set) var summary: CartSummary?
      @Published var selectedTab: AppTab = .cart
      @Published private(set) var products: [Product] = []
      @Published private(set) var categories: [Category] = []
    
      @Published var selectedCategoryId: String?
      @Published var selectedHomeCategoryId: String?
      @Published var selectedProductId: String?
    
    @Published var toastMessage: String?

    let cart: Cart
    let catalog: Catalog

    init() {
        let cart = Cart()
        let catalog = Catalog()
        self.cart = cart
        self.catalog = catalog
        
        loadCatalog()
        seed()     // temp demo data
        refresh()  // 👈 load into UI
    }
    
    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }
    
    func selectCategory(id: String) {
        selectedCategoryId = id
    }
    
    func selectHomeCategory(id: String?) {
        selectedHomeCategoryId = id
    }
    
    func selectProduct(id: String) {
        selectedProductId = id
    }

    func closeProductDetail() {
        selectedProductId = nil
    }
    
    func showToast(_ message: String) {
        toastMessage = message

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.toastMessage == message {
                self.toastMessage = nil
            }
        }
    }
    
    func clearSelectedCategory() {
        selectedCategoryId = nil
    }
}


extension AppState {
    private func seed() {
        addProductToCart(id: "sneakers")
        addProductToCart(id: "jacket")
        addProductToCart(id: "backpack")
//        cart.addItem(
//            id: "sneakers",
//            name: "Classic White Sneakers",
//            imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=300&q=80",
//            size: "9",
//            color: "White",
//            priceCents: 5999
//        )
//
//        cart.addItem(
//            id: "jacket",
//            name: "Denim Jacket",
//            imageUrl: "https://images.unsplash.com/photo-1551537482-f2075a1d41f2?auto=format&fit=crop&w=300&q=80",
//            size: "M",
//            color: "Blue",
//            priceCents: 8999
//        )
//
//        cart.addItem(
//            id: "backpack",
//            name: "Everyday Backpack",
//            imageUrl: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=300&q=80",
//            size: nil,
//            color: "Black",
//            priceCents: 4999
//        )
    }
}

extension AppState {
    private func mutateCart(_ operation: () -> Void) {
        operation()
        refresh()
    }

    private func refresh() {
        items = cart.listItems()
        summary = cart.summary()
    }
}

extension AppState {
    func incrementItem(id: String) {
        mutateCart {
            cart.incrementItem(id: id)
        }
    }

    func decrementItem(id: String) {
        mutateCart {
            cart.decrementItem(id: id)
        }
    }

    func removeItem(id: String) {
        mutateCart {
            cart.removeItem(id: id)
        }
    }

    func addItem(
        id: String,
        name: String,
        imageUrl: String,
        size: String?,
        color: String,
        priceCents: UInt32
    ) {
        mutateCart {
            cart.addItem(
                id: id,
                name: name,
                imageUrl: imageUrl,
                size: size,
                color: color,
                priceCents: priceCents
            )
        }
    }
}

//extension AppState {
////    func refresh() {
////        items = cart.listItems()
////        summary = cart.summary()
////    }
//    
//    private func perform(_ block: () -> Void) {
//        block()
//        refresh()
//    }
//    
//    func incrementItem(id: String) {
//        perform {
//            cart.incrementItem(id: id)
//        }
//    }
//
//    func decrementItem(id: String) {
//        perform {
//            cart.decrementItem(id: id)
//        }
//    }
//
//    func removeItem(id: String) {
//        perform {
//            cart.removeItem(id: id)
//        }
//    }
//}

extension AppState {
    func loadCatalog() {
        products = catalog.listProducts()
        categories = catalog.listCategories()
    }
    
    func addProductToCart(id: String) {
        guard let product = products.first(where: { $0.id == id }) else {
            return
        }

        mutateCart {
            cart.addProduct(product: product)
        }

        showToast("Added to cart")
    }
    
//    func addProductToCart(id: String) {
//        guard let product = products.first(where: { $0.id == id }) else {
//            return
//        }
//
//        mutateCart {
//            cart.addProduct(product: product)
//        }
//    }
}
