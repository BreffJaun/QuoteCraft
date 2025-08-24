//
//  EditQuoteSheet.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 21.08.25.
//

import SwiftUI
import SwiftData

struct EditQuoteSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    // Vorausgefüllte Quote
    var initialQuote: Quote
    
    @State private var currentUser: User?
    @State private var title: String
    @State private var quote: String
    @State private var authorName: String
    @State private var selectedCategories: Set<Category>
    
    // Initializer, to fill the fields 
    init(currentUserId: String?, initialQuote: Quote) {
        self.initialQuote = initialQuote
//        self._currentUserId = AppStorage(wrappedValue: currentUserId, "currentUserId")
        self._title = State(initialValue: initialQuote.title)
        self._quote = State(initialValue: initialQuote.quote)
        self._authorName = State(initialValue: initialQuote.authorName)
        self._selectedCategories = State(initialValue: Set(initialQuote.categories))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // TITLE
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Title")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter quote title...", text: $title)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                    
                    // QUOTE
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Quote")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        QuoteTextEditor(quote: $quote)
                            .frame(minHeight: 100)
                    }
                    .padding(.horizontal)
                    
                    // AUTHOR NAME
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Author name")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter author name...", text: $authorName)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                    
                    // FAVORITE CATEGORIES
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
                    
                    // SAVE BUTTON
                    Button {
                        guard currentUser != nil else { return }
                        
                        // Update bestehende Quote
                        initialQuote.title = title
                        initialQuote.quote = quote
                        initialQuote.authorName = authorName
                        initialQuote.categories = Array(selectedCategories)
                        
                        // Speichern
                        try? context.save()
                        dismiss()
                        
                    } label: {
                        Text("Save Changes")
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
            .navigationTitle("Edit Quote")
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
//    EditQuoteSheet()
//}
