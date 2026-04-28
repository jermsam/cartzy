//
//  ProductImageView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct ProductImageView: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()

            case .failure:
                Image(systemName: "photo")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)

            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 96, height: 96)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(14)
    }
}

#Preview("Success") {
    ProductImageView(
        url: "https://images.unsplash.com/photo-1600269452121-4f2416e55c28?q=80&w=1365&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    )
}

#Preview("Failure") {
    ProductImageView(url: "invalid-url")
}
