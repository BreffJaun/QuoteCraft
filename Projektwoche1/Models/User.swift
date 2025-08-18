//
//  user.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation
import SwiftData

@Model
class User {
    var id: UUID = UUID()
    var username: String
    var favCategoryRaw: [String] = []
    var favCategories: [Category] {
        get { favCategoryRaw.compactMap { Category(rawValue: $0) } }
        set { favCategoryRaw = newValue.map { $0.rawValue } }
    }
    @Relationship var favQuotes: [Quote] = []
    @Relationship(inverse: \Quote.createdBy) var createdQuotes: [Quote] = []
    
    init(
        id: UUID,
        username: String,
        favCategories: [Category] = [],
        favQuotes: [Quote] = [],
        createdQuotes: [Quote] = []
    ){
        self.id = id
        self.username = username
        self.favCategoryRaw = favCategories.map { $0.rawValue }
        self.favQuotes = favQuotes
        self.createdQuotes = createdQuotes
    }
}
