//
//  Quote.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation
import SwiftData

@Model
class Quote: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var authorName: String
    var title: String
    var quote: String
    var categoriesRaw: [String] = []
    var categories: [Category] {
        get { categoriesRaw.compactMap { Category(rawValue: $0) } }
        set { categoriesRaw = newValue.map { $0.rawValue } }
    }
    
    @Relationship var createdBy: User
    
    init(id: UUID,
         authorName: String,
         title: String,
         quote: String,
         categories: [Category] = [],
         createdBy: User
    ){
        self.id = id
        self.authorName = authorName
        self.title = title
        self.quote = quote
        self.categoriesRaw = categories.map { $0.rawValue }
        self.createdBy = createdBy
    }
}






