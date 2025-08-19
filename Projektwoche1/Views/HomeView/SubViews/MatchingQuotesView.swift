//
//  MatchingQuotesView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData

struct MatchingQuotesView: View {
    
    @Query private var users: [User]
    @Query private var quotes: [Quote]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var currentUser: User?
    
    var matchingQuotes: [Quote] {
        guard let currentUser else { return [] }
        return quotes.filter { quote in
            !quote.categories.isEmpty &&
            quote.categories.contains(where: { currentUser.favCategories.contains($0) })
        }
        .sorted { quote1, quote2 in
            let match1 = quote1.categories.filter { currentUser.favCategories.contains($0) }.count
            let match2 = quote2.categories.filter { currentUser.favCategories.contains($0) }.count
            return match1 > match2
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Matching Quotes")
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let currentUser = currentUser {
                if matchingQuotes.isEmpty {
                    HStack {
                        Text("No matching Quotes found.")
                        Spacer()
                    }
                } else {
                    ForEach(matchingQuotes, id: \.id) { quote in
                        let matchingCount = quote.categories.filter { currentUser.favCategories.contains($0) }.count
                        NavigationLink(destination: QuoteDetailView(quote: quote)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(quote.title)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    Text("\(matchingCount) matching Categories out of \(quote.categories.count)")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 16)
                            .background(
                                ZStack {
                                    RoundedRectangle()
                                        .fill(.ultraThinMaterial)
                                
                                    RoundedRectangle()
                                        .fill(quote.categories[0].gradient)
                                    
                                    RoundedRectangle()
                                        .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                }
                            )
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                    }
                }
            } else {
                Text("Loading user...")
                    .foregroundColor(.gray)
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
        if let currentUserId, let uuid = UUID(uuidString: currentUserId),
           let foundUser = users.first(where: { $0.id == uuid }) {
            currentUser = foundUser
        } else if let firstUser = users.first {
            // Kein User-ID gesetzt → ersten User nehmen
            currentUser = firstUser
            currentUserId = firstUser.id.uuidString
        }
    }
}

#Preview {
    MatchingQuotesView()
}



//private func loadCurrentUser() {
//    if let currentUserId,
//       let uuid = UUID(uuidString: currentUserId),
//       let foundUser = users.first(where: { $0.id == uuid }) {
//        currentUser = foundUser
//    }
//}
