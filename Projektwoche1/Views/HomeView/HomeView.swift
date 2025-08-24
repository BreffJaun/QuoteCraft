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
                    .disabled(currentUserId?.isEmpty ?? true)
                    .opacity((currentUserId?.isEmpty ?? true) ? 0.5 : 1.0)
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
