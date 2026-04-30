//
//  ProductHeroImageView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct ProductHeroImageView: View {
    let url: String
    @State private var timedOut = false

    var body: some View {
        ZStack {
            if timedOut {
                fallback
            } else {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    timedOut = true
                                }
                            }

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()

                    case .failure:
                        fallback

                    @unknown default:
                        fallback
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 340)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private var fallback: some View {
        Image(systemName: "photo")
            .font(.system(size: 42))
            .foregroundColor(.gray)
    }
}
