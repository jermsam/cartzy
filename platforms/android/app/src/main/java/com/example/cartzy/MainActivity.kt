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
import uniffi.cartzy_core.Cart
import uniffi.cartzy_core.Category

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
fun CartzyApp(initialGreeting: String = "Loading...") {
    var greeting by remember { mutableStateOf(initialGreeting) }
    var cart: Cart? by remember { mutableStateOf(null) }
    var category: Category? by remember { mutableStateOf(null) }

    if (initialGreeting == "Loading...") {
        LaunchedEffect(Unit) {
            val newCart = Cart()
            cart = newCart

        }
    }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = greeting,
            style = MaterialTheme.typography.headlineMedium
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        Button(onClick = {

        }) {
            Text("Refresh")
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
    CartzyApp(initialGreeting = "Hello from JFFI")
}
