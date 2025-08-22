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
    @State private var quoteToDelete: Quote? = nil
    @State private var showDeleteAlert = false
    
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
                List {
                    ForEach(filteredQuotes) { quote in
                        ZStack {
                            // Unsichtbarer NavigationLink im Hintergrund
                            NavigationLink(destination: QuoteDetailView(quote: quote)) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            // Sichtbarer Inhalt
                            QuoteListItemView(quote: quote)
                                .contentShape(Rectangle())
                                .padding(.vertical, 6)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .swipeActions(edge: .trailing) {
                            if let currentUser {
                                if currentUser.createdQuotes.contains(where: { $0.id == quote.id }) {
                                    Button(role: .destructive) {
                                        quoteToDelete = quote
                                        showDeleteAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                
                                // Favorit togglen
                                let isFav = currentUser.favQuotes.contains(where: { $0.id == quote.id })
                                Button {
                                    if isFav {
                                        if let idx = currentUser.favQuotes.firstIndex(where: { $0.id == quote.id }) {
                                            currentUser.favQuotes.remove(at: idx)
                                        }
                                    } else {
                                        currentUser.favQuotes.append(quote)
                                    }
                                } label: {
                                    Label(isFav ? "Unfavorite" : "Favorite", systemImage: isFav ? "star.fill" : "star")
                                }
                                .tint(isFav ? .yellow : .gray)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                
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
