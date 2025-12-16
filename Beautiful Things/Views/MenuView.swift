//
//  MenuView.swift
//  Beautiful Things
//
//  The main content view in a NavigationSplitView showing the categories and grid of cards.
//

import SwiftUI

struct MenuView: View {
    @Environment(AppModel.self) private var appModel
    @State private var selectedCategory: String? = "Featured"
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedCategory) {
                Section(header: Text("Trending").foregroundColor(.gray)) {
                    NavigationLink("Featured", value: "Featured")
                    NavigationLink("New", value: "New")
                }
                
                Section(header: Text("Collections").foregroundColor(.gray)) {
                    // Generate a list of categories for each unique category in the dataset.
                    ForEach(uniqueCategories.sorted(), id: \.self) { category in
                        NavigationLink(category, value: category)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Aura Fashion")
        } detail: {
            VStack {
                HStack {
                    Image("AF")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 8)
                    Text("Try on sunglasses in AR - pinch, hold, and drag to bring fashion into your world.")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                .padding()
                
                // Update GridView based on the selected category.
                if let selectedCategory = selectedCategory {
                        GridView(selectedCategory: selectedCategory)
                }
            }
            .padding(.top, -100) // Negative padding to move the "Pinch, hold..." text above the GridView's ScrollView.
        }
        .navigationDestination(for: String.self) { category in
                GridView(selectedCategory: category)
        }
    }
    
    private var uniqueCategories: Set<String> {
        Set(appModel.beautifulThings.map { $0.category })
    }
}
