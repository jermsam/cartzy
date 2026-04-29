use url::Url;

pub struct ImageOptimizer;

impl ImageOptimizer {
    pub fn optimize_unsplash_url(original_url: &str, width: u32, height: u32) -> String {
        let mut url = match Url::parse(original_url) {
            Ok(u) => u,
            Err(_) => return original_url.to_string(),
        };

        url.query_pairs_mut()
            .clear()
            .append_pair("w", &width.to_string())
            .append_pair("h", &height.to_string())
            .append_pair("fit", "crop")
            .append_pair("q", "80")
            .append_pair("auto", "format");

        url.to_string()
    }

    pub fn optimize_product_thumbnail(original_url: &str) -> String {
        Self::optimize_unsplash_url(original_url, 300, 300)
    }

    pub fn optimize_product_detail(original_url: &str) -> String {
        Self::optimize_unsplash_url(original_url, 800, 800)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_optimize_unsplash_url() {
        let original = "https://images.unsplash.com/photo-1542291026-7eec264c27ff";
        let optimized = ImageOptimizer::optimize_unsplash_url(original, 300, 300);
        
        assert!(optimized.contains("w=300"));
        assert!(optimized.contains("h=300"));
        assert!(optimized.contains("fit=crop"));
        assert!(optimized.contains("q=80"));
        assert!(optimized.contains("auto=format"));
    }

    #[test]
    fn test_optimize_product_thumbnail() {
        let original = "https://images.unsplash.com/photo-1542291026-7eec264c27ff";
        let optimized = ImageOptimizer::optimize_product_thumbnail(original);
        
        assert!(optimized.contains("w=300"));
        assert!(optimized.contains("h=300"));
    }

    #[test]
    fn test_invalid_url_returns_original() {
        let invalid = "not-a-valid-url";
        let result = ImageOptimizer::optimize_unsplash_url(invalid, 300, 300);
        
        assert_eq!(result, invalid);
    }
}
