# Image Optimization Implementation

## Overview

Image optimization has been implemented on the Rust side to ensure consistent, efficient image delivery across all platforms (iOS, Android, Web). This approach centralizes the logic and prevents clients from downloading unnecessarily large images.

## Implementation Details

### 1. Image Optimizer Module (`core/src/image_optimizer.rs`)

The `ImageOptimizer` provides methods to optimize Unsplash image URLs using Imgix rendering parameters:

```rust
pub struct ImageOptimizer;

impl ImageOptimizer {
    pub fn optimize_unsplash_url(original_url: &str, width: u32, height: u32) -> String
    pub fn optimize_product_thumbnail(original_url: &str) -> String  // 300x300
    pub fn optimize_product_detail(original_url: &str) -> String     // 800x800
}
```

### 2. Optimization Parameters

The optimizer applies the following Imgix/Unsplash parameters:

- **`w`** (width): Target image width in pixels
- **`h`** (height): Target image height in pixels
- **`fit=crop`**: Crops the image to exact dimensions
- **`q=80`**: Quality setting (80% - good balance between quality and file size)
- **`auto=format`**: Automatically serves WebP/AVIF to supporting clients

### 3. Benefits

#### Bandwidth Control
- Prevents downloading 10MB+ original files
- Reduces mobile data usage
- Faster load times

#### Automatic Format Optimization
- Modern browsers receive WebP/AVIF (smaller file sizes)
- Legacy browsers receive JPEG/PNG
- No client-side logic needed

#### Centralized Logic
- Single source of truth for image optimization
- Easy to update parameters across all platforms
- Consistent behavior on iOS, Android, and Web

#### Performance
- Smaller images = faster downloads
- Reduced memory usage on mobile devices
- Better user experience

## Usage in Catalog

The `Catalog` module now uses the optimizer for all product images:

```rust
Product {
    id: "sneakers".into(),
    name: "Classic White Sneakers".into(),
    image_url: ImageOptimizer::optimize_product_thumbnail(
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff"
    ),
    // ... other fields
}
```

## URL Transformation Example

**Before:**
```
https://images.unsplash.com/photo-1542291026-7eec264c27ff
```

**After:**
```
https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&q=80&auto=format
```

## Testing

The module includes comprehensive unit tests:

```bash
cd core
cargo test image_optimizer
```

Tests cover:
- URL optimization with custom dimensions
- Thumbnail preset (300x300)
- Detail preset (800x800)
- Invalid URL handling (returns original)

## Future Enhancements

### 1. Dynamic Sizing
Add device-specific optimization based on screen density:

```rust
pub fn optimize_for_device(url: &str, device_type: DeviceType) -> String {
    match device_type {
        DeviceType::Phone => optimize_unsplash_url(url, 300, 300),
        DeviceType::Tablet => optimize_unsplash_url(url, 600, 600),
        DeviceType::Desktop => optimize_unsplash_url(url, 1200, 1200),
    }
}
```

### 2. On-the-Fly Image Processing
For non-Unsplash images, use Rust image processing libraries:

```toml
[dependencies]
image = "0.25"
```

```rust
use image::imageops::FilterType;

pub fn resize_local_image(path: &str, width: u32, height: u32) -> Result<Vec<u8>> {
    let img = image::open(path)?;
    let resized = img.resize_exact(width, height, FilterType::Lanczos3);
    // Convert to bytes and return
}
```

### 3. CDN Integration
Integrate with Cloudflare Images or similar services:

```rust
pub fn optimize_via_cdn(url: &str, width: u32, height: u32) -> String {
    format!("https://cdn.example.com/cdn-cgi/image/width={},height={},fit=crop/{}", 
            width, height, url)
}
```

### 4. Caching Strategy
Add URL caching to avoid repeated transformations:

```rust
use std::collections::HashMap;
use std::sync::Mutex;

lazy_static! {
    static ref URL_CACHE: Mutex<HashMap<String, String>> = Mutex::new(HashMap::new());
}
```

## Dependencies

Added to `core/Cargo.toml`:

```toml
[dependencies]
url = "2.5"  # For URL parsing and manipulation
```

## Platform Integration

### iOS (SwiftUI)
The optimized URLs are automatically used when loading images:

```swift
AsyncImage(url: URL(string: product.imageUrl))
```

### Android (Kotlin)
```kotlin
Coil.load(product.imageUrl)
```

### Web (React)
```jsx
<img src={product.imageUrl} alt={product.name} />
```

All platforms receive pre-optimized URLs from the Rust core, ensuring consistency.

## Performance Metrics

Typical file size reductions:
- **Original Unsplash image**: ~8-12 MB
- **Optimized thumbnail (300x300)**: ~15-30 KB
- **Optimized detail (800x800)**: ~80-150 KB

**Bandwidth savings**: ~99% for thumbnails, ~98% for detail views

## Maintenance

To adjust optimization parameters globally:

1. Edit `core/src/image_optimizer.rs`
2. Modify quality, dimensions, or fit mode
3. Run tests: `cargo test`
4. Rebuild: `make build PLATFORM=ios`
5. Deploy to all platforms

No frontend code changes required!
