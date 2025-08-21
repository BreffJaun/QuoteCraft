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
            
            VStack(alignment: .leading, spacing: 12) {
                QuoteOfTheDayView()
                Divider()
                    .frame(height: 0.5)
                    .background(Color.white)
                MatchingQuotesView()
            }
            .padding()
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddQuoteSheet.toggle()
                    } label: {
                        Image(systemName: "plus.bubble.fill")
                            .foregroundColor(Color.pinkAccent)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showUserProfileSheet.toggle()
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(Color.pinkAccent)
                    }
                }
            }
            .sheet(isPresented: $showUserProfileSheet) {
                UserProfilSheet()
            }
            .sheet(isPresented: $showAddQuoteSheet) {
                AddQuoteSheet()
            }
            .onAppear {
                // users => UNSORTED "QUANTITY" of Data
                //                if currentUserId == nil {
                //                    if let firstUser = users.first {
                //                        currentUserId = firstUser.id.uuidString
                //                    } else {
                //                        // Wen ken User vorhanden → Test-User erstellen
                //                        let testUser = User(id: UUID(), username: "TestUser", favCategories: [.miscellaneous, .movie, .series])
                //                        context.insert(testUser)
                //                        currentUserId = testUser.id.uuidString
                //                    }
                //                }
                print("Alle User in DB:")
                users.forEach { print($0.username) }
                
                if let oli = users.first(where: { $0.username == "Oliver" }) {
                    print("Oliver gefunden ✅")
                    currentUserId = oli.id.uuidString
                } else if let firstUser = users.first {
                    print("Oliver nicht gefunden ❌, nehme \(firstUser.username)")
                    currentUserId = firstUser.id.uuidString
                } else {
                    print("Kein User vorhanden → TestUser wird erstellt")
                    let testUser = User(id: UUID(), username: "TestUser", favCategories: [.miscellaneous, .movie, .series])
                    context.insert(testUser)
                    currentUserId = testUser.id.uuidString
                }
                
            }
            .background(
                LinearGradient(
                    colors: [
                        Color("HomeGradientStart"),
                        Color("HomeGradientMiddle"),
                        Color("HomeGradientEnd")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }
}

//#Preview {
//    HomeView()
//}
