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
    @State private var mode: QuoteMode = .daily
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                // Header mit Titel + Shuffle-Button
                HStack {
                    Text("Quote")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.primary)
                    Spacer()
                    if mode == .random {
                        Button {
                            showRandomQuote()
                        } label: {
                            Image(systemName: "shuffle.circle.fill")
                                .font(.title2.weight(.bold))
                        }
                    }
                    
                    // Button zur Detailansicht
                    Button {
                        showDetail = true
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title2.weight(.bold))
                    }
                }
                
                // Segmented Picker für Daily vs Random
                Picker("Mode", selection: $mode) {
                    ForEach(QuoteMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                
                // Quote Text
                Text("“\(currentQuote.quote)”")
                    .font(.body.italic())
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.primary.opacity(0.3))
                
                // Infos (Title, Author & CreatedBy)
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
                
                // Kategorien
                VStack(alignment: .leading, spacing: 4) {
                    Text("Categories")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
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
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
                    setQuoteForCurrentMode()
                }
            }
            .onChange(of: mode) {
                setQuoteForCurrentMode()
            }
            .navigationDestination(isPresented: $showDetail) {
                QuoteDetailView(quote: currentQuote)
            }
        }
    }
    
    private func setQuoteForCurrentMode() {
        switch mode {
        case .daily:
            currentQuote = quotes.first ?? currentQuote
        case .random:
            showRandomQuote()
        }
    }
    
    private func showRandomQuote() {
        currentQuote = quotes.randomElement() ?? currentQuote
    }
}

//#Preview {
//    QuoteOfTheDayView()
//}
