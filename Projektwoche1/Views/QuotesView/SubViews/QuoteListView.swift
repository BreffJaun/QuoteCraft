//
//  QuoteListView.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI
import SwiftData

struct QuoteListView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var quoteList: [Quote]
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var currentUser: User?
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
                if quoteList.isEmpty {
                    VStack {
                        Spacer(minLength: 20)
                        Text("No results found 😢")
                            .foregroundColor(.secondary)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Spacer(minLength: 20)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                } else {
                    ForEach(displayedQuotes) { quote in
//                        NavigationLink {
//                            QuoteDetailView(quote: quote)
//                        } label: {
//                            QuoteListItemView(quote: quote)
//                                .contentShape(Rectangle())
//                                .padding(.vertical, 6)
//                        }
                        // Hide Disclosure Indicator 🤓
                        // https://www.devtechie.com/community/public/posts/225203-how-to-hide-disclosure-indicator-from-navigationlink-in-swiftui
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
                                        context.delete(quote)

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
                                    //                                    try? context.save()
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
    
    // Hilfsfunktion zum Filtern und Sortieren von Zitaten
    private func filterAndSortQuotes(quotes: [Quote], searchString: String, sortOrder: [SortDescriptor<Quote>]) -> [Quote] {
            // Filtern nach Suchstring
            let filtered = searchString.isEmpty ? quotes : quotes.filter { quote in
                quote.title.localizedCaseInsensitiveContains(searchString) ||
                quote.quote.localizedCaseInsensitiveContains(searchString) ||
                quote.authorName.localizedCaseInsensitiveContains(searchString) ||
                quote.createdBy.username.localizedCaseInsensitiveContains(searchString)
            }
            
            // Sortieren
            return filtered.sorted(using: sortOrder)
        }
}

//}
//
//#Preview {
//    QuoteListView()
//}
