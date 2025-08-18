//
//  QuoteOfTheDayView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData

struct QuoteOfTheDayView: View {
    
    @Query private var quotes: [Quote]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quote of the day")
                .font(.headline)
            Text("Title: \(randomQuote.title)")
            Text(randomQuote.quote)
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Category:")
                    Text(randomQuote.categoryRaw)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Author:")
                    Text(randomQuote.authorName)
                }
            }
            Divider()
            Button {
                
            } label: {
                Text("Random Quote")
            }
            .tint(.green)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
    
    private var randomQuote: Quote {
        quotes.randomElement() ?? Quote(
            id: UUID(),
            authorName: "Unknown",
            title: "No title",
            quote: "No quote",
            category: .miscellaneous,
            createdBy: User(id: UUID(), username: "Unknown")
        )
    }
}

//#Preview {
//    QuoteOfTheDayView()
//}
