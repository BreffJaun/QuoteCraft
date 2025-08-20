//
//  QuoteListItemView.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI


struct QuoteListItemView: View {
    
    var quote: Quote
    
    var body: some View {
        HStack{
            VStack{
                Text("Title")
                Text(quote.title)
            }
            
        }
    }
}

//#Preview {
//    QuoteListItemView()
//}
