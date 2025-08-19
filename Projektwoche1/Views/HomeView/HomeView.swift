//
//  HomeView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var quotes: [Quote]
    
    @State private var showUserProfileSheet: Bool = false
    @State private var showAddQuoteSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    QuoteOfTheDayView()
                    Divider()
                    MatchingQuotesView()
                }
                .padding()
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddQuoteSheet.toggle()
                    } label: {
                        Image(systemName: "plus.bubble")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showUserProfileSheet.toggle()
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
            .sheet(isPresented: $showUserProfileSheet) {
                UserProfilSheet()
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
