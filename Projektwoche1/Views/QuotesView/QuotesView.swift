//
//  QuotesView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import SwiftUI
import SwiftData


struct QuotesView: View {
    @Environment(\.modelContext) private var context
    @Query private var quotes: [Quote]
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    @State private var showAddQuoteSheet: Bool = false
    @State private var searchString: String = ""
    @State private var currSortOrder: SortOrder = .title
    var body: some View {
        NavigationStack {
            VStack{
                TextField("search for quotes...", text: $searchString)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal, 8)
            }
            HStack {
                Picker("Sort", selection: $currSortOrder) {
                    ForEach(SortOrder.allCases) { order in
                        Text(order.title)
                    }
                }
                Spacer()
            }
            ScrollView {
//                ForEach(filtertQuotes()) { quote in
//                    NavigationLink{
//                        QuoteDetailView(quote: quote)
//                    } label: {
//                        QuoteListItemView(quote: quote)
//                    }
//                }
//                QuoteListView(sortOrder: currSortOrder.sortDescriptors,searchString: searchString)
//                    .animation(.default, value: currSortOrder)
            }
            .navigationTitle("Quotes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddQuoteSheet.toggle()
                    } label: {
                        Image(systemName: "plus.bubble")
                            .foregroundColor(Color.pinkAccent)
                    }
                }
                
            }
            .sheet(isPresented: $showAddQuoteSheet) {
                AddQuoteSheet()
            }
            .frame(maxWidth: .infinity)
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
            
            
            
            
        }
        
    }
//    private func filtertQuotes() -> [Quote] {
//        if searchString.isEmpty {
//            return quotes
//        } else {
//            let descriptor = FetchDescriptor<Quote>(
//                predicate: #Predicate {
//                    $0.title.localizedStandardContains(searchString)
//                    || $0.quote.localizedStandardContains(searchString)
//                    || $0.authorName.localizedStandardContains(searchString)
//                    || $0.createdBy.username.localizedStandardContains(searchString)
//                },
//                sortBy: [SortDescriptor(\Quote.title)]
//            )
//        return try! context.fetch(descriptor)
//        }
//    }
}


//#Preview {
//    QuotesView()
//}








