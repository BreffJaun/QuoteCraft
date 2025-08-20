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
    @State private var currentQuote: Quote = Quote(
        id: UUID(),
        authorName: "Unknown",
        title: "No title",
        quote: "No quote",
        categories: [.miscellaneous],
        createdBy: User(id: UUID(), username: "Unknown")
    )
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Quote of the Day")
                .font(.title2.weight(.semibold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("“\(currentQuote.quote)”")
                .font(.body.italic())
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
            
            Divider()
                .frame(height: 1)
                .background(Color.primary.opacity(0.3))
                .frame(height: 1)
            
            // Infos (Title, Author & Category-Tag in einer Zeile)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Title")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text(currentQuote.title)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Author")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text(currentQuote.authorName)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Created by")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text(currentQuote.createdBy.username)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Category")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                HStack {
                    FlowLayoutQOTD(data: currentQuote.categories, spacing: 8) { category in
                        Text(category.rawValue)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                ZStack {
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                    
                                    Capsule()
                                        .fill(category.gradient)
                                    
                                    Capsule()
                                        .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                                }
                            )
                            .foregroundColor(.white) // bleibt weiß, da Badge
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                showRandomQuote()
            } label: {
                Text("Show Random Quote")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
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
            if currentQuote.authorName == "Unknown" {
                showRandomQuote()
            }
        }
    }
    
    private func showRandomQuote() {
        currentQuote = quotes.randomElement() ?? currentQuote
    }
}

//#Preview {
//    QuoteOfTheDayView()
//}
