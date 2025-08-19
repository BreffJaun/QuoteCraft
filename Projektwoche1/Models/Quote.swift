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
    @Attribute(.unique) var id: UUID = UUID()
    var authorName: String
    var title: String
    var quote: String
    var categoryRaw: String
    var category: Category {
        get { Category(rawValue: categoryRaw) ?? .miscellaneous }
        set { categoryRaw = newValue.rawValue }
    }
    
    @Relationship var createdBy: User
    
    init(id: UUID, authorName: String, title: String, quote: String, category: Category, createdBy: User) {
        self.id = id
        self.authorName = authorName
        self.title = title
        self.quote = quote
        self.categoryRaw = category.rawValue
        self.createdBy = createdBy
    }
}






