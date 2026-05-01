package com.example.cartzy

import androidx.lifecycle.ViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import uniffi.cartzy_core.Cart

data class AppUiState(
    val greeting: String = ""
)

class AppViewModel : ViewModel() {
    private val cart = Cart()

    private val _uiState = MutableStateFlow(
        AppUiState(

        )
    )

    val uiState: StateFlow<AppUiState> = _uiState.asStateFlow()

    fun refreshGreeting() {
        _uiState.update { currentState ->
            currentState.copy(

            )
        }
    }

    override fun onCleared() {
        super.onCleared()
        // Clean up core resources if needed
    }
}
