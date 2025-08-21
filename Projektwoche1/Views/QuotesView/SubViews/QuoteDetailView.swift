//
//  QuoteDetailView.swift
//  Projektwoche1
//
//  Created by Romina Reiber on 19.08.25.
//

import SwiftUI
import SwiftData

struct QuoteDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var isFavorite: Bool = false
    @State private var currentUser: User?
    
    var quote: Quote
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Title")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text(quote.title)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                
                Divider()
                    .frame(height: 0.5)
                    .overlay(Color.white)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Quote")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    Text("“\(quote.quote)”")
                        .font(.body.italic())
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Divider()
                    .frame(height: 0.5)
                    .overlay(Color.white)
                
                HStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Author")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.secondary)
                        Text(quote.authorName)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
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
                
                Divider()
                    .frame(height: 0.5)
                    .overlay(Color.white)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Categories")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    
                    FlowLayoutQOTD(data: quote.categories, spacing: 6) { category in
                        CategoryBadgeView(category: category, isEllipsis: false)
                    }
                }
                
                HStack(spacing: 40) {
                    Button {
                        toggleFavorite()
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title2)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .foregroundColor(Color.pinkAccent)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    // Löschen (nur wenn createdBy == currentUser)
                    if currentUser?.id == quote.createdBy.id {
                        Button(role: .destructive) {
                            context.delete(quote)
//                            try? context.save()
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                                .font(.title2)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .foregroundColor(.red)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 12)

            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            .padding()
        }
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
            .ignoresSafeArea()
        )
        .navigationTitle("Quote Details")
        .navigationBarTitleDisplayMode(.inline)
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
            isFavorite = user.favQuotes.contains(where: { $0.id == quote.id })
        }
    }
        
    private func toggleFavorite() {
        guard let user = currentUser else { return }
        
        if let index = user.favQuotes.firstIndex(where: { $0.id == quote.id }) {
            user.favQuotes.remove(at: index)
            isFavorite = false
        } else {
            user.favQuotes.append(quote)
            isFavorite = true
        }
        
    }
}

//#Preview {
//    QuoteDetailView(
//        quote: Quote(
//            title: "Inception",
//            quote: "You mustn't be afraid to dream a little bigger, darling.",
//            authorName: "Eames",
//            createdBy: User(id: UUID(), username: "Jeff", favCategories: [.movie]),
//            categories: [.movie, .inspirational]
//        )
//    )
//}


//#Preview {
//    QuoteDetailView()
//}
