//
//  SuitableQuotesView.swift
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
    
    @State private var currentUser: User = User(id: UUID(), username: "Unknown")
    
    var matchingQuotes: [Quote] {
        (quotes as [Quote])
            .filter { quote in
            !quote.categories.isEmpty &&
            quote.categories.contains(where: {currentUser.favCategories.contains($0)})
        }
        .sorted { quote1, quote2 in
            let match1 = quote1.categories.filter {
                currentUser.favCategories.contains($0)
            }.count
            let match2 = quote2.categories.filter {
                currentUser.favCategories.contains($0)
            }.count
            return match1 > match2
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Matching Quotes")
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            if matchingQuotes.isEmpty {
                HStack {
                    Text("No matching Quotes found.")
                    Spacer()
                    Text(currentUser.username)
                }
            } else {
                ForEach(matchingQuotes, id: \.id) { (quote: Quote) in
                    let matchingCount = quote.categories.filter {
                        currentUser.favCategories.contains($0)
                    }.count
                    NavigationLink(destination: QuoteDetailView(quote: quote)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(quote.title)
                                Text("\(matchingCount) machting Categories out of \(quote.categories.count)")
                            }
                        }
                    }
                }
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
            if currentUser.username == "Unknown" {
                getCurrentUser()
            }
        }
    }
    private func getCurrentUser() {
        if let currentUserId,
           let uuid = UUID(uuidString: currentUserId),
           let foundUser = users.first(where: { $0.id == uuid }) {
            currentUser = foundUser
        }
    }
}

#Preview {
    MatchingQuotesView()
}
