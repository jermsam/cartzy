use std::sync::Arc;
use crate::image_optimizer::ImageOptimizer;

#[derive(uniffi::Record, Clone)]
pub struct Product {
    pub id: String,
    pub name: String,
    pub image_url: String,
    pub category_id: String,
    pub price_cents: u32,
    pub color: String,
    pub size: Option<String>,
}

#[derive(uniffi::Record, Clone)]
pub struct Category {
    pub id: String,
    pub name: String,
    pub icon: String,
}

#[derive(uniffi::Object)]
pub struct Catalog {
    products: Vec<Product>,
    categories: Vec<Category>,
}

#[uniffi::export]
impl Catalog {
    #[uniffi::constructor]
    pub fn new() -> Arc<Self> {
        Arc::new(Self {
            categories: vec![
                Category {
                    id: "shoes".into(),
                    name: "Shoes".into(),
                    icon: "shoeprints.fill".into(),
                },
                Category {
                    id: "jackets".into(),
                    name: "Jackets".into(),
                    icon: "jacket".into(),
                },
                Category {
                    id: "bags".into(),
                    name: "Bags".into(),
                    icon: "bag.fill".into(),
                },
            ],
            products: vec![
                Product {
                    id: "sneakers".into(),
                    name: "Classic White Sneakers".into(),
                    image_url: ImageOptimizer::optimize_product_thumbnail(
                        "https://cdn.shopify.com/s/files/1/1002/1104/files/unnamed_48ae1068-ec4d-45ce-ab94-33f71773269b_600x600.jpg?v=1607959717"
                    ),
                    category_id: "shoes".into(),
                    price_cents: 5999,
                    color: "White".into(),
                    size: Some("9".into()),
                },
                Product {
                    id: "jacket".into(),
                    name: "Denim Jacket".into(),
                    image_url: ImageOptimizer::optimize_product_thumbnail(
                        "https://shopsteelcity.com/cdn/shop/files/blue-denim-jacket-front_1_1_800x.jpg?v=1773331363"
                    ),
                    category_id: "jackets".into(),
                    price_cents: 8999,
                    color: "Blue".into(),
                    size: Some("M".into()),
                },
                Product {
                    id: "backpack".into(),
                    name: "Everyday Backpack".into(),
                    image_url: ImageOptimizer::optimize_product_thumbnail(
                        "https://cdn.packhacker.com/2022/04/2126e354-lululemon-everyday-backpack-2.0-23l.jpg"
                    ),
                    category_id: "bags".into(),
                    price_cents: 4999,
                    color: "Black".into(),
                    size: None,
                },
            ],
        })
    }

    pub fn list_categories(&self) -> Vec<Category> {
        self.categories.clone()
    }

    pub fn list_products(&self) -> Vec<Product> {
        self.products.clone()
    }

    pub fn featured_products(&self) -> Vec<Product> {
        self.products.clone()
    }

    pub fn products_for_category(&self, category_id: String) -> Vec<Product> {
        self.products
            .iter()
            .filter(|product| product.category_id == category_id)
            .cloned()
            .collect()
    }

    pub fn product_by_id(&self, id: String) -> Option<Product> {
        self.products
            .iter()
            .find(|product| product.id == id)
            .cloned()
    }

    pub fn get_product_detail_image_url(&self, product_id: String) -> Option<String> {
        let base_urls = vec![
            ("sneakers", "https://images.unsplash.com/photo-1542291026-7eec264c27ff"),
            ("jacket", "https://images.unsplash.com/photo-1551537482-f2075a1d41f2"),
            ("backpack", "https://images.unsplash.com/photo-1553062407-98eeb64c6a62"),
        ];

        base_urls
            .iter()
            .find(|(id, _)| *id == product_id)
            .map(|(_, url)| ImageOptimizer::optimize_product_detail(url))
    }
}