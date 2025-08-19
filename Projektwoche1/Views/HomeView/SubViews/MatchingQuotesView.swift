//
//  SuitableQuotesView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData

struct MatchingQuotesView: View {
    
    var matchingQuotes: [Quote] = []
    
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
                }
            } else {
                ForEach(matchingQuotes) { quote in
//                    var matchingCount = quote.categories.filter {
//
//                    }
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

#Preview {
    MatchingQuotesView()
}
