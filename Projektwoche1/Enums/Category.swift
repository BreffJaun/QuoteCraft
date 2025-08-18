//
//  Category.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation


enum Category: String, CaseIterable, Identifiable {
    case movie = "Movie"
    case series = "Series"
    case literature = "Literature"
    case music = "Music"
    case famousPeople = "Famous People"
    case games = "Games"
    case miscellaneous = "Miscellaneous"
    
    var id: String { rawValue }
}
