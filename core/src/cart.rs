use crate::catalog::Product;
use std::sync::{Arc, Mutex};

#[derive(Clone)]
struct CartItem {
    id: String,
    name: String,
    image_url: String,
    size: Option<String>,
    color: String,
    price_cents: u32,
    quantity: u32,
}

#[derive(uniffi::Record)]
pub struct CartItemView {
    pub id: String,
    pub name: String,
    pub image_url: String,
    pub size: Option<String>,
    pub color: String,
    pub price_cents: u32,
    pub quantity: u32,
    pub line_total_cents: u32,
}

#[derive(uniffi::Record)]
pub struct CartSummary {
    pub item_count: u32,
    pub subtotal_cents: u32,
    pub shipping_cents: u32,
    pub tax_cents: u32,
    pub total_cents: u32,
    pub qualifies_for_free_shipping: bool,
}

#[derive(uniffi::Object)]
pub struct Cart {
    items: Mutex<Vec<CartItem>>,
}

#[uniffi::export]
impl Cart {
    #[uniffi::constructor]
    pub fn new() -> Arc<Self> {
        Arc::new(Self {
            items: Mutex::new(vec![]),
        })
    }

    pub fn add_item(
        &self,
        id: String,
        name: String,
        image_url: String,
        size: Option<String>,
        color: String,
        price_cents: u32,
    ) {
        let mut items = self.items.lock().unwrap();

        if let Some(item) = items.iter_mut().find(|i| i.id == id) {
            item.quantity += 1;
        } else {
            items.push(CartItem {
                id,
                name,
                image_url,
                size,
                color,
                price_cents,
                quantity: 1,
            });
        }
    }

    pub fn increment_item(&self, id: String) {
        let mut items = self.items.lock().unwrap();

        if let Some(item) = items.iter_mut().find(|i| i.id == id) {
            item.quantity += 1;
        }
    }

    pub fn decrement_item(&self, id: String) {
        let mut items = self.items.lock().unwrap();

        if let Some(item) = items.iter_mut().find(|i| i.id == id) {
            if item.quantity > 1 {
                item.quantity -= 1;
            } else {
                items.retain(|i| i.id != id);
            }
        }
    }

    pub fn remove_item(&self, id: String) {
        let mut items = self.items.lock().unwrap();
        items.retain(|i| i.id != id);
    }

    pub fn list_items(&self) -> Vec<CartItemView> {
        self.items
            .lock()
            .unwrap()
            .iter()
            .map(|i| CartItemView {
                id: i.id.clone(),
                name: i.name.clone(),
                image_url: i.image_url.clone(),
                size: i.size.clone(),
                color: i.color.clone(),
                price_cents: i.price_cents,
                quantity: i.quantity,
                line_total_cents: i.price_cents * i.quantity,
            })
            .collect()
    }

    pub fn summary(&self) -> CartSummary {
        let items = self.items.lock().unwrap();

        let item_count: u32 = items.iter().map(|i| i.quantity).sum();

        let subtotal_cents: u32 = items
            .iter()
            .map(|i| i.price_cents * i.quantity)
            .sum();

        let qualifies_for_free_shipping = subtotal_cents >= 100_00;

        let shipping_cents = if subtotal_cents == 0 || qualifies_for_free_shipping {
            0
        } else {
            10_00
        };

        let tax_cents = subtotal_cents * 8 / 100;
        let total_cents = subtotal_cents + shipping_cents + tax_cents;

        CartSummary {
            item_count,
            subtotal_cents,
            shipping_cents,
            tax_cents,
            total_cents,
            qualifies_for_free_shipping,
        }
    }

    pub fn add_product(&self, product: Product) {
        self.add_item(
            product.id,
            product.name,
            product.image_url,
            product.size,
            product.color,
            product.price_cents,
        );
    }
}