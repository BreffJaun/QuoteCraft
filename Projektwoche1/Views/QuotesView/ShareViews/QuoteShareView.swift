//
//  QuoteShareView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 21.08.25.
//

import SwiftUI

struct QuoteShareView: View {
    let quote: Quote
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 8) {
                Text(quote.title)
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 60, height: 2)
            }
            
            // Quote
            Text("\"\(quote.quote)\"")
                .font(.title2.italic())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 20)
            
            // Author
            VStack(spacing: 4) {
                Text("— \(quote.authorName)")
                    .font(.headline.weight(.medium))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("shared by @\(quote.createdBy.username)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Categories (optional, falls Platz)
            if quote.categories.count <= 3 {
                HStack(spacing: 8) {
                    ForEach(quote.categories.prefix(3), id: \.self) { category in
                        Text("#\(category.rawValue)")
                            .font(.caption.weight(.medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(40)
        .frame(width: 400, height: 600)
        .background(
            LinearGradient(
                colors: [
                    Color("HomeGradientStart"),
                    Color("HomeGradientMiddle"),
                    Color("HomeGradientEnd")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

//#Preview {
//    QuoteShareView()
//}
