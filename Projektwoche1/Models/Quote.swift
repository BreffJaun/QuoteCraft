//
//  Quote.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation
import SwiftData

@Model
class Quote {
    var id: UUID = UUID()
    var authorName: String
    var title: String
    var quote: String
    var category: Category
    
    @Relationship(inverse: \User.username) var createdBy: User
    
    init(id: UUID, authorName: String, title: String, quote: String, category: Category, createdBy: User) {
        self.id = id
        self.authorName = authorName
        self.title = title
        self.quote = quote
        self.category = category
        self.createdBy = createdBy
    }
}






