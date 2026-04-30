//
//  ProfileView.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/29/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                VStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 72))
                        .foregroundColor(.blue)

                    Text("Alex Morgan")
                        .font(.title2.bold())

                    Text("alex@example.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 24)

                profileRow(icon: "shippingbox", title: "Orders", subtitle: "View your order history")
                profileRow(icon: "heart", title: "Favorites", subtitle: "Saved products")
                profileRow(icon: "creditcard", title: "Payment", subtitle: "Manage cards")
                profileRow(icon: "gearshape", title: "Settings", subtitle: "App preferences")
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 18)
        }
        .background(Color(.systemGroupedBackground))
    }

    private func profileRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.blue)
                .frame(width: 52, height: 52)
                .background(Color.blue.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    ProfileView()
}
