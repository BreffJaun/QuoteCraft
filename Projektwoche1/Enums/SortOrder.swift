//
//  SortOrder.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 20.08.25.
//

import Foundation

enum SortOrder: Identifiable, CaseIterable {
    case title, titleDescending, newest
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
            case .title: return "Title"
            case .titleDescending: return "Title desc."
            case .newest: return "Newest"
        }
    }
    
    var sortDescriptors: [SortDescriptor<Note>] {
        switch self {
        case .title: return  [SortDescriptor(\Note.title)]
        case .titleDescending: return [SortDescriptor(\Note.title, order: .reverse)]
        case .newest: return [SortDescriptor(\Note.time, order: .reverse)]
        }
    }
}
