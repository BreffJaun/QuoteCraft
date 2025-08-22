//
//  FilteredQuoteListView.swift
//  QuoteCraft
//
//  Created by Jeff Braun on 22.08.25.
//

import SwiftUI
import SwiftData

struct FilteredQuoteListView: View {
    @Environment(\.modelContext) private var context
    @Query private var quotes: [Quote]
    
    let whichQuoteListType: favQuotes
    let sortOrder: [SortDescriptor<Quote>]
    let searchString: String
    let selectedCategory: Category?
    
    @AppStorage("currentUserId") private var currentUserId: String?
    @State private var currentUser: User?
    
    private var filteredQuotes: [Quote] {
        var filtered = quotes
        
        // Filter by search string
        if !searchString.isEmpty {
            filtered = filtered.filter { quote in
                quote.title.localizedCaseInsensitiveContains(searchString) ||
                quote.quote.localizedCaseInsensitiveContains(searchString) ||
                quote.authorName.localizedCaseInsensitiveContains(searchString)
            }
        }
        
        // Filter by category
        if let selectedCategory = selectedCategory {
            filtered = filtered.filter { quote in
                quote.categories.contains(selectedCategory)
            }
        }
        
        // Filter by favorites if needed
        if whichQuoteListType == .favQuotes, let user = currentUser {
            let favoriteIds = Set(user.favQuotes.map(\.id))
            filtered = filtered.filter { favoriteIds.contains($0.id) }
        }
        
        // Apply sorting
        return filtered.sorted { lhs, rhs in
            for descriptor in sortOrder {
                let result = descriptor.compare(lhs, rhs)
                if result != .orderedSame {
                    return result == .orderedAscending
                }
            }
            return false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView {
                LazyVStack(spacing: 12) {
                    if filteredQuotes.isEmpty {
                        ContentUnavailableView {
                            Label("No Quotes Found", systemImage: "quote.bubble")
                        } description: {
                            if selectedCategory != nil {
                                Text("No quotes found in this category")
                            } else if !searchString.isEmpty {
                                Text("No quotes match your search")
                            } else {
                                Text("No quotes available")
                            }
                        }
                        .padding(.top, 50)
                    } else {
                        ForEach(filteredQuotes) { quote in
                            NavigationLink(destination: QuoteDetailView(quote: quote)) {
                                QuoteListItemView(quote: quote)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
        .onAppear {
            loadCurrentUser()
        }
    }
    
    private func loadCurrentUser() {
        guard let idString = currentUserId,
              let uuid = UUID(uuidString: idString) else { return }
        
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.id == uuid }
        )
        if let user = try? context.fetch(descriptor).first {
            currentUser = user
        }
    }
}
//#Preview {
//    FilteredQuoteListView()
//}
