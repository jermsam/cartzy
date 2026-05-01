package com.example.cartzy

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    CartzyApp()
                }
            }
        }
    }
}

@Composable
fun CartzyApp(
    viewModel: AppViewModel = viewModel()
) {
    val uiState by viewModel.uiState.collectAsState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        if (uiState.isCatalogLoading) {
            CircularProgressIndicator()
            Spacer(modifier = Modifier.height(8.dp))
            Text("Loading catalog...")
        } else {
            Text(
                text = "${uiState.products.size} products, ${uiState.categories.size} categories",
                style = MaterialTheme.typography.headlineSmall
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "${uiState.cartItems.size} cart items",
                style = MaterialTheme.typography.bodyLarge
            )
            Spacer(modifier = Modifier.height(8.dp))
            uiState.summary?.let { summary ->
                Text(
                    text = "Total: $${summary.totalCents / 100u}.${(summary.totalCents % 100u).toString().padStart(2, '0')}",
                    style = MaterialTheme.typography.bodyLarge
                )
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        Button(onClick = { viewModel.loadCatalog() }) {
            Text("Reload Catalog")
        }
    }
}

@Preview(
    name = "Cartzy Screen",
    showBackground = true,
    backgroundColor = 0xFFF5F5F5
)
@Composable
fun CartzyAppPreview() {
    MaterialTheme {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = "3 products, 3 categories",
                style = MaterialTheme.typography.headlineSmall
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "3 cart items",
                style = MaterialTheme.typography.bodyLarge
            )
            Spacer(modifier = Modifier.height(16.dp))
            Button(onClick = {}) {
                Text("Reload Catalog")
            }
        }
    }
}
