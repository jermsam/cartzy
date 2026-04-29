//
//  BottomMenuView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation
import SwiftUI

struct BottomMenuView: View {
    let selectedTab: AppTab
    let itemCount: UInt32
    let onSelect: (AppTab) -> Void

    var body: some View {
        HStack {
            TabItemView(icon: "house", title: "Home", selected: selectedTab == .home)
                .onTapGesture { onSelect(.home) }

            Spacer()

            TabItemView(icon: "square.grid.2x2", title: "Categories", selected: selectedTab == .categories)
                .onTapGesture { onSelect(.categories) }

            Spacer()

            TabItemView(
                icon: "cart",
                title: "Cart",
                selected: selectedTab == .cart,
                badgeCount: itemCount
            )
            .onTapGesture { onSelect(.cart) }

            Spacer()

            TabItemView(icon: "person", title: "Profile", selected: selectedTab == .profile)
                .onTapGesture { onSelect(.profile) }
        }
        .padding(.horizontal, 36)
        .padding(.top, 12)
        .padding(.bottom, 24)
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: -4)
    }
}

struct TabItemView: View {
    let icon: String
    let title: String
    let selected: Bool
    var badgeCount: UInt32 = 0

    var body: some View {
        VStack(spacing: 5) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.system(size: 25))

                if selected, badgeCount > 0 {
                    Text("\(badgeCount)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 12, y: -10)
                }
            }

            Text(title)
                .font(.system(size: 13, weight: selected ? .semibold : .regular))
        }
        .foregroundColor(selected ? .blue : .secondary)
    }
}



#Preview {
    VStack {
        Spacer()

        BottomMenuView(
            selectedTab: .cart,
            itemCount: 3,
            onSelect: { _ in }
        )
    }
    .background(Color(.systemGroupedBackground))
}
