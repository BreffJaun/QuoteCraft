//
//  AddQuoteSheet.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI
import SwiftData

struct AddQuoteSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var currentUser: User? {
        didSet {
            createdBy = currentUser?.username ?? ""
        }
    }
    @State private var title: String = ""
    @State private var quote: String = ""
    @State private var authorName: String = ""
    @State private var createdBy: String = ""
    @State private var selectedCategories: Set<Category> = []
    @State private var entryCategory: Category = .miscellaneous
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: TITLE
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Title")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        ZStack(alignment: .trailing) {
                            TextField("Enter quote title...", text: $title)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            
                            
                            if !title.isEmpty {
                                Button(action: {
                                    title = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: QUOTE
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Quote")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        ZStack(alignment: .trailing) {
                            QuoteTextEditor(quote: $quote)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: AUTHOR NAME
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Author name")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        ZStack(alignment: .trailing) {
                            TextField("Enter author name...", text: $authorName)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            
                            
                            if !authorName.isEmpty {
                                Button(action: {
                                    authorName = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: AUTHOR NAME
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Created by")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        ZStack(alignment: .trailing) {
                            TextField("Enter by who is this quote created...", text: $createdBy)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .disabled(true)
                                .foregroundColor(.primary.opacity(0.5))
                            Image(systemName: "lock.fill")
                                .padding(.trailing, 12)
                                .foregroundColor(.gray.opacity(0.8))
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: FAVORITE CATEGORIES
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Favorite Categories")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Menu {
                            ForEach(Category.allCases.filter { $0 != .ellipsis }, id: \.rawValue) { category in
                                Button {
                                    if !selectedCategories.contains(category) {
                                        selectedCategories.insert(category)
                                    }
                                } label: {
                                    Label(category.rawValue, systemImage: selectedCategories.contains(category) ? "checkmark" : "")
                                }
                            }
                        } label: {
                            HStack {
                                Text("Add Category")
                                Spacer()
                                Image(systemName: "plus.circle")
                            }
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        if selectedCategories.isEmpty {
                            Text("No Categories selected yet!")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        } else {
                            FlowLayoutUPS(data: Array(selectedCategories), spacing: 8) { category in
                                Text(category.rawValue)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(
                                        ZStack {
                                            Capsule()
                                                .fill(.ultraThinMaterial)
                                            
                                            Capsule()
                                                .fill(category.gradient)
                                            
                                            Capsule()
                                                .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                        }
                                    )
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        selectedCategories.remove(category)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Button {
                        guard let currentUser else { return }
                        
                        let newQuote = Quote(
                            id: UUID(),
                            authorName: authorName,
                            title: title,
                            quote: quote,
                            categories: Array(selectedCategories),
                            createdBy: currentUser
                        )
                        
                        context.insert(newQuote)
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color.accentColor)
                            )
                            .padding(.horizontal)
                            .shadow(radius: 4)
                    }
                    .disabled(
                        authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        || quote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        || selectedCategories.isEmpty
                        || currentUser == nil
                    )
                    .opacity(
                        (authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        || quote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        || selectedCategories.isEmpty
                        || currentUser == nil)
                        ? 0.5 : 1.0 
                    )

                }
            }
            .navigationTitle("Add New Quote")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                LinearGradient(
                    colors: [Color("HomeGradientStart"),
                             Color("HomeGradientMiddle"),
                             Color("HomeGradientEnd")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                            .bold()
                    }
                }
            }
            .onAppear {
                loadCurrentUser()
            }
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
        }
    }
}

//#Preview {
//    AddQuoteSheet()
//}

