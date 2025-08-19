//
//  Category.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation
import SwiftUICore


enum Category: String, CaseIterable, Identifiable {
    case movie = "Movie"
    case series = "Series"
    case literature = "Literature"
    case music = "Music"
    case famousPeople = "Famous People"
    case games = "Games"
    case miscellaneous = "Miscellaneous"
    
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
        }
    }
}
