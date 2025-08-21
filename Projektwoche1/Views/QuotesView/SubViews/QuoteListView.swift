//
//  QuoteListView.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI
import SwiftData

struct QuoteListView: View {
    
    @Query private var quoteList: [Quote]
    
    init(sortOrder: [SortDescriptor<Quote>], searchString: String) {
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
                ScrollView {
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
                    } else {
                        ForEach(quoteList) { quote in
                            NavigationLink {
                                QuoteDetailView(quote: quote)
                            } label: {
                                QuoteListItemView(quote: quote)
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
    }
}

//}
//
//#Preview {
//    QuoteListView()
//}
