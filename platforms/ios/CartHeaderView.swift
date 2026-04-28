//
//  CartHeaderView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct CartHeaderView: View {
    let itemCount: UInt32

    var body: some View {
        HStack(alignment: .center) {
            Text("Shopping Cart")
                .font(.system(size: 34, weight: .bold))

            Spacer()

            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.system(size: 30, weight: .regular))

                if itemCount > 0 {
                    Text("\(itemCount)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 12, y: -12)
                }
            }
        }
        .padding(.bottom, 6)
    }
}

#Preview {
    VStack(spacing: 24) {
        CartHeaderView(itemCount: 0)
        CartHeaderView(itemCount: 3)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
