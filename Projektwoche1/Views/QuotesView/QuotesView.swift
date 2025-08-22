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
    @State private var whichQuoteList: favQuotes = .nonFavQuotes
        
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
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
                
                HStack {
                    Picker("Sort", selection: $currSortOrder) {
                        ForEach(SortOrder.allCases) { order in
                            Text(order.title)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
                            
//                let animationDuration = min(0.8, max(0.3, Double(quotes.count) * 1.20))
                QuoteListView(
                    whichQuoteListType: whichQuoteList,
                    sortOrder: currSortOrder.sortDescriptors,
                    searchString: searchString
                )
//                .animation(.easeInOut(duration: animationDuration), value: currSortOrder)
                .animation(.default, value: currSortOrder)
                .padding(.horizontal)
                .padding(.top, 4)
            }
            .navigationTitle("Quotes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddQuoteSheet.toggle()
                    } label: {
                        Image(systemName: "plus.bubble.fill")
                            .foregroundColor(Color.pinkAccent)
                    }
                    .disabled(currentUserId?.isEmpty ?? true)
                    .opacity((currentUserId?.isEmpty ?? true) ? 0.5 : 1.0)
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
//    QuotesView()
//}








