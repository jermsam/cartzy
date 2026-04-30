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
            Button {
                onSelect(.home)
            } label: {
                TabItemView(icon: "house", title: "Home", selected: selectedTab == .home)
            }
            .buttonStyle(.plain)

            Spacer()

            Button {
                onSelect(.categories)
            } label: {
                TabItemView(icon: "square.grid.2x2", title: "Categories", selected: selectedTab == .categories)
            }
            .buttonStyle(.plain)

            Spacer()

            Button {
                onSelect(.cart)
            } label: {
                TabItemView(
                    icon: "cart",
                    title: "Cart",
                    selected: selectedTab == .cart,
                    badgeCount: itemCount
                )
            }
            .buttonStyle(.plain)

            Spacer()

            Button {
                onSelect(.profile)
            } label: {
                TabItemView(icon: "person", title: "Profile", selected: selectedTab == .profile)
            }
            .buttonStyle(.plain)
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

                if badgeCount > 0 {
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
