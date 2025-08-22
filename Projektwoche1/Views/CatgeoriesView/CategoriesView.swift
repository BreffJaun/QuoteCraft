//
//  CategoriesView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Environment(\.modelContext) private var context
    @Query private var quotes: [Quote]
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var showAddQuoteSheet: Bool = false
    @State private var searchString: String = ""
    @State private var currSortOrder: SortOrder = .title
    @State private var whichQuoteList: favQuotes = .nonFavQuotes
    @State private var selectedCategory: Category? = nil
        
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                // Search Bar
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        
                        ZStack(alignment: .trailing) {
                            TextField("Search for quotes...", text: $searchString)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .padding(.trailing, 24)
                            if !searchString.isEmpty {
                                Button(action: {
                                    searchString = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 4)
                            }
                        }
                    }
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(.horizontal)
                
                // Horizontal Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        // "All" Filter Chip
                        CategoryFilterChip(
                            title: "All",
                            isSelected: selectedCategory == nil,
                            gradient: LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        ) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedCategory = nil
                            }
                        }
                        
                        // Category Filter Chips
                        ForEach(Category.allCases.filter { $0 != .ellipsis }) { category in
                            CategoryFilterChip(
                                title: category.rawValue,
                                isSelected: selectedCategory == category,
                                gradient: category.gradient
                            ) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedCategory = selectedCategory == category ? nil : category
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 4)
                
                // Sort Order Picker
                HStack {
                    Picker("Sort", selection: $currSortOrder) {
                        ForEach(SortOrder.allCases) { order in
                            Text(order.title)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
                            
                // Quote List with Category Filter
                FilteredQuoteListView(
                    whichQuoteListType: whichQuoteList,
                    sortOrder: currSortOrder.sortDescriptors,
                    searchString: searchString,
                    selectedCategory: selectedCategory
                )
                .animation(.default, value: currSortOrder)
                .animation(.default, value: selectedCategory)
                .padding(.horizontal)
                .padding(.top, 4)
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddQuoteSheet.toggle()
                    } label: {
                        Image(systemName: "plus.bubble.fill")
                            .foregroundColor(Color.pinkAccent)
                    }
                }
            }
            .sheet(isPresented: $showAddQuoteSheet) {
                AddQuoteSheet()
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
        }
    }
}
//#Preview {
//    CategoriesView()
//}
