//
//  SortOrder.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 20.08.25.
//

import Foundation

enum SortOrder: Identifiable, CaseIterable {
    case title,authorName, createdBy, quote
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
            case .title: return "Title"
            case .authorName: return "Author Name"
            case .createdBy: return "Created By"
            case .quote: return "Quote"
        }
    }
    
    var sortDescriptors: [SortDescriptor<Quote>] {
        switch self {
        case .title: return  [SortDescriptor(\Quote.title)]
        case .authorName: return [SortDescriptor(\Quote.authorName, order: .forward)]
        case .createdBy: return [SortDescriptor(\Quote.createdBy.username, order: .forward)]
        case .quote: return [SortDescriptor(\Quote.quote, order: .forward)]
        }
    }
}
