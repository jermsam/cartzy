import SwiftUI

struct ProductCardView: View {
    let product: Product
    let onAddToCart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                ProductImageView(url: product.imageUrl)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 22))

                Button {
                    // future favorite action
                } label: {
                    Image(systemName: "heart")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(width: 34, height: 34)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(10)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(product.name)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(2)

                Text("\(product.color)\(product.size != nil ? " • Size \(product.size!)" : "")")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)

                HStack {
                    Text(formatMoney(product.priceCents))
                        .font(.system(size: 17, weight: .bold))

                    Spacer()

                    Button {
                        withAnimation {
                            onAddToCart()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 2)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    ProductCardView(
        product: Product(
            id: "sneakers",
            name: "Classic White Sneakers",
            imageUrl: "https://martinvalen.com/38216-mv_large_default/chunky-sneakers-shoes-white.jpg",
            categoryId: "shoes",
            priceCents: 5999,
            color: "White",
            size: "9"
        ),
        onAddToCart: {}
    )
    .frame(width: 190)
    .padding()
    .background(Color(.systemGroupedBackground))
    .previewLayout(.sizeThatFits)
}
