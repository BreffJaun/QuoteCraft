//
//  ContentView.swift
//  Projektwoche1
//
//  Created by Jana Jansen on 24.01.25.
//

import SwiftUI
import SwiftData
import UIKit

struct TabBarView: View {
  
    
    init() {
        UITabBar.appearance().tintColor = UIColor(named: "IconAccent")
    }

    
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
        .tint(Color("PinkAccent"))
    }
}
    

#Preview {
    TabBarView()
//        .modelContainer(for: [
//            User.self,
//            Quote.self
//        ], inMemory: true)
        .modelContainer(DataManager.previewContainer)
}
