//
//  QuoteMode.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 21.08.25.
//

import Foundation

enum QuoteMode: String, CaseIterable, Identifiable {
    case daily = "Daily"
    case random = "Random"
    var id: String { rawValue }
}

