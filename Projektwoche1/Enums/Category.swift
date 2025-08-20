//
//  Category.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Identifiable, Codable {
    case movie = "Movie"
    case series = "Series"
    case literature = "Literature"
    case music = "Music"
    case famousPeople = "Famous People"
    case games = "Games"
    case miscellaneous = "Miscellaneous"
        
    case funny = "Funny"
    case philosophy = "Philosophy"
    case science = "Science"
    case history = "History"
    case motivation = "Motivation"
    case art = "Art"
    case technology = "Technology"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case ellipsis = "Ellipsis"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .movie: return .red
        case .series: return .blue
        case .literature: return .purple
        case .music: return .orange
        case .famousPeople: return .pink
        case .games: return .green
        case .miscellaneous: return .gray
            
        case .funny: return .yellow
        case .philosophy: return .brown
        case .science: return .teal
        case .history: return .indigo
        case .motivation: return .mint
        case .art: return .cyan
        case .technology: return .primary
        case .fantasy: return .pink
        case .scienceFiction: return .purple
        case .ellipsis: return .black
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .movie:
            return LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .series:
            return LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .literature:
            return LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .music:
            return LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .famousPeople:
            return LinearGradient(colors: [.mint, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .games:
            return LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .miscellaneous:
            return LinearGradient(colors: [.gray, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case .funny:
            return LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .philosophy:
            return LinearGradient(colors: [.brown, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .science:
            return LinearGradient(colors: [.teal, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .history:
            return LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .motivation:
            return LinearGradient(colors: [.mint, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .art:
            return LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .technology:
            return LinearGradient(colors: [.gray, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .fantasy:
            return LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .scienceFiction:
            return LinearGradient(colors: [.purple, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case .ellipsis:
            return LinearGradient(colors: [.black, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
