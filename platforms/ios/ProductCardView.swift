import SwiftUI

struct ProductCardView: View {
    let product: Product
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onAddToCart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // 🖼 Image + favorite
            HStack {
                ZStack(alignment: .topTrailing) {
                    ProductImageView(url: product.imageUrl)

                    Button {
                        onToggleFavorite()
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(isFavorite ? .red : .primary)
                            .frame(width: 34, height: 34)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .offset(x: 8, y: -8)
                }

                Spacer()
            }

            // 📄 Info
            VStack(alignment: .leading, spacing: 6) {
                Text(product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)

                Text("\(product.color)\(product.size != nil ? " • Size \(product.size!)" : "")")
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack {
                    Text(formatMoney(product.priceCents))
                        .font(.headline.bold())

                    Spacer()

                    // ➕ Add to cart
                    Button {
                        onAddToCart()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.04), radius: 8, y: 4)
    }
}

#Preview {
    ProductCardView(
        product: Product(
            id: "jacket",
            name: "Denim Jacket",
            imageUrl: "https://cdn-images.farfetch-contents.com/28/06/21/72/28062172_57557673_600.jpg",
            categoryId: "jackets",
            priceCents: 8999,
            color: "Blue",
            size: "M"
        ),
        isFavorite: false,
        onToggleFavorite: {},
        onAddToCart: {}
    )
    .padding()
}
