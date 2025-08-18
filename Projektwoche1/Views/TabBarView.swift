//
//  ContentView.swift
//  Projektwoche1
//
//  Created by Jana Jansen on 24.01.25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            
            Tab("Quotes", systemImage: "quote.bubble") {
                QuotesView()
            }
            
            Tab("Favorites", systemImage: "star.circle") {
                FavoritesView()
            }
            
            Tab("Categories", systemImage: "sparkles.rectangle.stack.fill") {
                CategoriesView()
            }
        }
    }
}

#Preview {
    TabBarView()
        .modelContainer(for: [
            User.self,
            Quote.self
        ], inMemory: true)
}
