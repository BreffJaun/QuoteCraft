//
//  HomeView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var quotes: [Quote]
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
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
            .onAppear {
                if currentUserId == nil {
                    if let firstUser = users.first {
                        // Es gibt bereits User → einfach die ID des ersten Users setzen
                        currentUserId = firstUser.id.uuidString
                    } else {
                        // Kein User vorhanden → Test-User erstellen
                        let testUser = User(id: UUID(), username: "TestUser", favCategories: [.miscellaneous, .movie, .series])
                        context.insert(testUser)
                        currentUserId = testUser.id.uuidString
                    }
                }
            }

        }
    }
}

//#Preview {
//    HomeView()
//}
