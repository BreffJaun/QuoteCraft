//
//  QuoteListView.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI
import SwiftData

struct QuoteListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query private var quoteList: [Quote]
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var currentUser: User?
    @State private var quoteToDelete: Quote? = nil
    @State private var showDeleteAlert = false
    
    private var whichQuoteList: favQuotes
    private let sortOrder: [SortDescriptor<Quote>]
    private let searchString: String
    
    private var displayedQuotes: [Quote] {
        if whichQuoteList == .nonFavQuotes {
            return quoteList
        } else {
            let favQuotes = currentUser?.favQuotes ?? []
            return filterAndSortQuotes(quotes: favQuotes, searchString: searchString, sortOrder: sortOrder)
        }
    }
    
    init(whichQuoteListType: favQuotes, sortOrder: [SortDescriptor<Quote>], searchString: String) {
        
        self.whichQuoteList = whichQuoteListType
        self.sortOrder = sortOrder
        self.searchString = searchString
        
        let predicate = #Predicate<Quote> { quote in
            if searchString.isEmpty {
                return true
            } else {
                return quote.title.contains(searchString)
                || quote.quote.contains(searchString)
                || quote.authorName.contains(searchString)
                || quote.createdBy.username.contains(searchString)
            }
        }
        _quoteList = Query(filter: predicate, sort: sortOrder)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            List {
                if displayedQuotes.isEmpty {
                    ContentUnavailableView {
                        Label(
                            whichQuoteList == .favQuotes ? "No Favorites" : "No Quotes Found",
                            systemImage: whichQuoteList == .favQuotes ? "heart.slash" : "quote.bubble"
                        )
                    } description: {
                        if whichQuoteList == .favQuotes {
                            Text("You haven't added any favorites yet")
                        } else if !searchString.isEmpty {
                            Text("No quotes match your search")
                        } else {
                            Text("No quotes available")
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                } else {
                    ForEach(displayedQuotes) { quote in
                        // Hide Disclosure Indicator 🤓
                        // https://www.devtechie.com/community/public/posts/225203-how-to-hide-disclosure-indicator-from-navigationlink-in-swiftui
                        ZStack {
                            // Invisible NavigationLink in the background
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
                                
                                // Toggle favorit
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
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
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
        .alert("Delete Quote?", isPresented: $showDeleteAlert, presenting: quoteToDelete) { quote in
            Button("Delete", role: .destructive) {
                context.delete(quote)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: { quote in
            Text("Do you really want to delete this quote?")
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
    
    // Help function for filtering and sorting quotations
    private func filterAndSortQuotes(quotes: [Quote], searchString: String, sortOrder: [SortDescriptor<Quote>]) -> [Quote] {
            // Filtern nach Suchstring
            let filtered = searchString.isEmpty ? quotes : quotes.filter { quote in
                quote.title.localizedCaseInsensitiveContains(searchString) ||
                quote.quote.localizedCaseInsensitiveContains(searchString) ||
                quote.authorName.localizedCaseInsensitiveContains(searchString) ||
                quote.createdBy.username.localizedCaseInsensitiveContains(searchString)
            }
            
            // Sort
            return filtered.sorted(using: sortOrder)
        }
}

//}
//
//#Preview {
//    QuoteListView()
//}
