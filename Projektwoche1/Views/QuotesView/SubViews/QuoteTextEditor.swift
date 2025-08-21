//
//  QuoteTextEditor.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 21.08.25.
//

import SwiftUI
import SwiftData

struct QuoteTextEditor: View {
    
    @Binding var quote: String
    
    var placeholder: String = "Enter your quote..."
        
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Placeholder
            if quote.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // TextEditor
            TextEditor(text: $quote)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .frame(height: 150)
                .scrollContentBackground(.hidden)
                .overlay(
                    Button(action: {
                        quote = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .opacity(quote.isEmpty ? 0 : 1)
                            .padding(8)
                    }
                    , alignment: .topTrailing
                )
        }
        .animation(.default, value: quote)
    }
}

//#Preview {
//    QuoteTextEditor()
//}
