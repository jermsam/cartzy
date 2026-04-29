//
//  ShimmerView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

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

#Preview {
    ShimmerView()
        .frame(width: 96, height: 96)
        .cornerRadius(14)
}
