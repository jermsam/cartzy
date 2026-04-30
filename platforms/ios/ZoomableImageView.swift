//
//  ZoomableImageView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/30/26.
//

import Foundation
import SwiftUI

struct ZoomableImageView: View {
    let url: String

    @State private var scale: CGFloat = 1.0

    var body: some View {
        ProductHeroImageView(url: url)
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = max(1.0, min(value, 3.0))
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            scale = 1.0
                        }
                    }
            )
    }
}

#Preview {
    ZoomableImageView(
        url: "https://cdn-images.farfetch-contents.com/28/06/21/72/28062172_57557673_600.jpg"
    )
    .padding()
}
