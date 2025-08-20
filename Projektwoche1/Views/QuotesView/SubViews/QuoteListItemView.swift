//
//  QuoteListItemView.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI

struct QuoteListItemView: View {
    
    let quote: Quote
    
   
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Title")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                Text(quote.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            Divider()
                .frame(height: 0.5)
                .overlay(Color.white)
            
            // Infos: Author, Title, Created by
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Author")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text(quote.authorName)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Created by")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text(quote.createdBy.username)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Categories")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                
                let displayedCategories = Array(quote.categories.prefix(3))
                let needsEllipsis = quote.categories.count > 3
                let categoriesWithEllipsis: [Category?] = displayedCategories.map { $0 } + (needsEllipsis ? [nil] : [])

                FlowLayoutQOTD(data: categoriesWithEllipsis, spacing: 4) { item in
                    CategoryBadgeView(category: item, isEllipsis: item == nil)
                }
            }

            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.ultraThinMaterial) // Frosted Glass Effekt
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}




//#Preview {
//    QuoteListItemView()
//}
