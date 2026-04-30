import SwiftUI

struct ProductDetailView: View {
    let product: Product
    let onClose: () -> Void
    let onAddToCart: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    heroSection
                    productInfo
                }
                .padding(20)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))

            stickyAddToCartBar
        }
    }

    private var heroSection: some View {
        ZStack(alignment: .topLeading) {
            ProductHeroImageView(url: product.imageUrl)
        }
    }

    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(product.name)
                .font(.largeTitle.bold())

            Text(formatMoney(product.priceCents))
                .font(.title2.bold())

            Text("Color: \(product.color)")
                .foregroundColor(.secondary)

            if let size = product.size {
                Text("Size: \(size)")
                    .foregroundColor(.secondary)
            }

            Text("A clean everyday essential built for comfort, style, and daily use.")
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
    }

    private var stickyAddToCartBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(formatMoney(product.priceCents))
                    .font(.headline.bold())

                Text("Ready to ship")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button {
                onAddToCart()
            } label: {
                Text("Add to Cart")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(26)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 14)
        .padding(.bottom, 24)
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: -4)
    }
}

#Preview {
    ProductDetailView(
        product: Product(
            id: "sneakers",
            name: "Classic White Sneakers",
            imageUrl: "https://images.unsplash.com/photo-1600269452121-4f2416e55c28?q=80&w=900&auto=format&fit=crop",
            categoryId: "shoes",
            priceCents: 5999,
            color: "White",
            size: "9"
        ),
        onClose: {},
        onAddToCart: {}
    )
}
