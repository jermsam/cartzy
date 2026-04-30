import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Text("Categories")
                    .font(.largeTitle.bold())

                ForEach(appState.categories, id: \.id) { category in
                    Button {
                        appState.openCategoryProducts(id: category.id)
                    } label: {
                        CategoryRowView(category: category)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)
            .padding(.bottom, 18)
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    CategoriesView()
        .environmentObject(AppState())
}
