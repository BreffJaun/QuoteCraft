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
    var favCategories: [Category]
    @Relationship var favQuotes: [Quote] = []
    @Relationship(inverse: \Quote.createdBy) var createdQuotes: [Quote] = []
    
    init(id: UUID, username: String, favCategories: [Category], favQuotes: [Quote], createdQuotes: [Quote]) {
        self.id = id
        self.username = username
        self.favCategories = favCategories
        self.favQuotes = favQuotes
        self.createdQuotes = createdQuotes
    }
}
