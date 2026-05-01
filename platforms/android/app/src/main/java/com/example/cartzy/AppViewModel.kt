package com.example.cartzy

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import uniffi.cartzy_core.Cart
import uniffi.cartzy_core.CartItemView
import uniffi.cartzy_core.CartSummary
import uniffi.cartzy_core.Catalog
import uniffi.cartzy_core.Category
import uniffi.cartzy_core.Product

enum class AppTab {
    HOME, CATEGORIES, CART, PROFILE
}

sealed class Route {
    data class ProductDetail(val productId: String) : Route()
    data class CategoryProducts(val categoryId: String) : Route()
}

data class AppUiState(
    val products: List<Product> = emptyList(),
    val categories: List<Category> = emptyList(),
    val cartItems: List<CartItemView> = emptyList(),
    val summary: CartSummary? = null,
    val selectedTab: AppTab = AppTab.HOME,
    val selectedHomeCategoryId: String? = null,
    val selectedProductId: String? = null,
    val toastMessage: String? = null,
    val navigationPath: List<Route> = emptyList(),
    val favoriteProductIds: Set<String> = emptySet(),
    val isCatalogLoading: Boolean = true
)

class AppViewModel : ViewModel() {
    companion object {
        private const val TAG = "AppViewModel"
    }

    private val cart: Cart by lazy {
        try {
            Cart()
        } catch (t: Throwable) {
            Log.e(TAG, "Failed to create Cart: ${t.javaClass.simpleName}: ${t.message}")
            throw t
        }
    }

    private val catalog: Catalog by lazy {
        try {
            Catalog()
        } catch (t: Throwable) {
            Log.e(TAG, "Failed to create Catalog: ${t.javaClass.simpleName}: ${t.message}")
            throw t
        }
    }

    private val _uiState = MutableStateFlow(AppUiState())
    val uiState: StateFlow<AppUiState> = _uiState.asStateFlow()

    init {
        loadCatalog()
        seed()
        refreshCart()
    }

    // MARK: - Catalog

    fun loadCatalog() {
        _uiState.update { it.copy(isCatalogLoading = true) }
        try {
            val products = catalog.listProducts()
            val categories = catalog.listCategories()
            _uiState.update {
                it.copy(
                    products = products,
                    categories = categories,
                    isCatalogLoading = false
                )
            }
        } catch (t: Throwable) {
            Log.e(TAG, "loadCatalog failed: ${t.message}")
            _uiState.update { it.copy(isCatalogLoading = false) }
        }
    }

    // MARK: - Cart

    fun addProductToCart(productId: String) {
        val product = uiState.value.products.find { it.id == productId } ?: return
        try {
            cart.addProduct(product)
            refreshCart()
            showToast("Added to cart")
        } catch (t: Throwable) {
            Log.e(TAG, "addProductToCart failed: ${t.message}")
        }
    }

    fun incrementItem(id: String) {
        mutateCart { cart.incrementItem(id) }
    }

    fun decrementItem(id: String) {
        mutateCart { cart.decrementItem(id) }
    }

    fun removeItem(id: String) {
        mutateCart { cart.removeItem(id) }
    }

    private fun mutateCart(operation: () -> Unit) {
        try {
            operation()
            refreshCart()
        } catch (t: Throwable) {
            Log.e(TAG, "Cart operation failed: ${t.message}")
        }
    }

    private fun refreshCart() {
        try {
            val items = cart.listItems()
            val summary = cart.summary()
            _uiState.update { it.copy(cartItems = items, summary = summary) }
        } catch (t: Throwable) {
            Log.e(TAG, "refreshCart failed: ${t.message}")
        }
    }

    private fun seed() {
        try {
            listOf("sneakers", "jacket", "backpack").forEach { id ->
                uiState.value.products.find { it.id == id }?.let { product ->
                    cart.addProduct(product)
                }
            }
        } catch (t: Throwable) {
            Log.e(TAG, "seed failed: ${t.message}")
        }
    }

    // MARK: - Navigation

    fun selectTab(tab: AppTab) {
        _uiState.update { it.copy(selectedTab = tab) }
    }

    fun selectHomeCategory(id: String?) {
        _uiState.update { it.copy(selectedHomeCategoryId = id) }
    }

    fun selectProduct(id: String) {
        _uiState.update { it.copy(selectedProductId = id) }
    }

    fun closeProductDetail() {
        _uiState.update { it.copy(selectedProductId = null) }
    }

    fun openProductDetail(productId: String) {
        _uiState.update {
            it.copy(navigationPath = it.navigationPath + Route.ProductDetail(productId))
        }
    }

    fun openCategoryProducts(categoryId: String) {
        _uiState.update {
            it.copy(navigationPath = it.navigationPath + Route.CategoryProducts(categoryId))
        }
    }

    fun goBack() {
        _uiState.update {
            val path = it.navigationPath
            if (path.isNotEmpty()) {
                it.copy(navigationPath = path.dropLast(1))
            } else it
        }
    }

    fun resetNavigation() {
        _uiState.update { it.copy(navigationPath = emptyList()) }
    }

    // MARK: - Favorites

    fun toggleFavorite(id: String) {
        _uiState.update {
            val current = it.favoriteProductIds
            val updated = if (current.contains(id)) current - id else current + id
            it.copy(favoriteProductIds = updated)
        }
    }

    fun isFavorite(id: String): Boolean {
        return uiState.value.favoriteProductIds.contains(id)
    }

    // MARK: - Toast

    fun showToast(message: String) {
        _uiState.update { it.copy(toastMessage = message) }
        viewModelScope.launch {
            delay(1500)
            clearToastIfMatching(message)
        }
    }

    private fun clearToastIfMatching(message: String) {
        _uiState.update {
            if (it.toastMessage == message) it.copy(toastMessage = null) else it
        }
    }

    fun clearToast() {
        _uiState.update { it.copy(toastMessage = null) }
    }

    // MARK: - Helpers

    fun getProductById(id: String): Product? {
        return uiState.value.products.find { it.id == id }
    }

    fun getCategoryById(id: String): Category? {
        return uiState.value.categories.find { it.id == id }
    }

    fun getProductsForCategory(categoryId: String): List<Product> {
        return uiState.value.products.filter { it.categoryId == categoryId }
    }

    fun getFeaturedProducts(): List<Product> {
        return try { catalog.featuredProducts() } catch (_: Throwable) { uiState.value.products }
    }

    fun getProductDetailImageUrl(productId: String): String? {
        return try { catalog.getProductDetailImageUrl(productId) } catch (_: Throwable) { null }
    }

    override fun onCleared() {
        super.onCleared()
        try { cart.close() } catch (_: Throwable) {}
        try { catalog.close() } catch (_: Throwable) {}
    }
}
