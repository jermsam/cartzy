//
//  ProductImageView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct ShimmerView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.secondarySystemBackground)
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.secondarySystemBackground),
                        Color(.tertiarySystemBackground),
                        Color(.secondarySystemBackground)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geometry.size.width * 2)
                .offset(x: phase * geometry.size.width * 2 - geometry.size.width)
            }
        }
        .onAppear {
            withAnimation(
                Animation.linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
            ) {
                phase = 1
            }
        }
    }
}

struct ProductImageView: View {
    let url: String
    
    private var validURL: URL? {
        URL(string: url)
    }

    var body: some View {
        Group {
            if let validURL = validURL {
                AsyncImage(url: validURL) { phase in
            switch phase {
            case .empty:
                ShimmerView()
                    .onAppear {
                        print("📸 Loading image: \(url)")
                    }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .onAppear {
                        print("✅ Image loaded successfully: \(url)")
                    }

            case .failure(let error):
                Image(systemName: "photo")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)
                    .onAppear {
                        print("❌ Image failed to load: \(url)")
                        print("   Error: \(error.localizedDescription)")
                    }

            @unknown default:
                EmptyView()
            }
        }
            } else {
                // Invalid URL
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 22))
                        .foregroundColor(.orange)
                    Text("Invalid URL")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .onAppear {
                    print("⚠️ Invalid URL string: \(url)")
                }
            }
        }
        .frame(width: 96, height: 96)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(14)
    }
}

#Preview("Success") {
    ProductImageView(
        url: "https://cdn-images.farfetch-contents.com/28/06/21/72/28062172_57557673_600.jpg"
    )
}

#Preview("Failure") {
    ProductImageView(url: "invalid-url")
}
