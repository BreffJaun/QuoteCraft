//
//  QuoteListView.swift
//  Projektwoche1
//
//  Created by Oliver Bogumil on 20.08.25.
//

import SwiftUI
import SwiftData

//struct QuoteListView: View {
//    
//    @Query private var quoteList: [Quote]
//    
//    init(sortOrder: [SortDescriptor<Note>], searchString: String) {
//                let predicate = #Predicate<Note> { note in
//                if searchString.isEmpty {
//                    return true
//                } else {
//                    return note.title.contains(searchString) || note.text.contains(searchString)
//                }
//            }
//            _noteList = Query(filter: predicate, sort: sortOrder)
//        }
//        
//        var body: some View {
//            ForEach(noteList) { note in
//                NoteItemView(note: note)
//            }
//        }

//}
//
//#Preview {
//    QuoteListView()
//}
