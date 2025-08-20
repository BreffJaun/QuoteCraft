//
//  QuoteDetailView.swift
//  Projektwoche1
//
//  Created by Romina Reiber on 19.08.25.
//

import SwiftUI

struct QuoteDetailView: View {
    
    var quote: Quote
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Title")
                Text(quote.title)
                Text("Quote")
                Text(quote.quote)
                Text("Author")
                Text(quote.authorName)
                Text("CreatedBy")
                Text(quote.createdBy.username)
                Text("Categories")
                ForEach(quote.categories) { category in
                    Text(category.rawValue)
                }
            }
        }
    }
}

//#Preview {
//    QuoteDetailView()
//}
