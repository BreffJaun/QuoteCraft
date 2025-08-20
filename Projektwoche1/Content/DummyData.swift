//
//  DummyData.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation

// Dummy Users
let dummyUsers: [User] = [
    User(
        id: UUID(),
        username: "Jeff",
        favCategories: [.movie, .music, .funny, .series, .history]
    ),
    User(
        id: UUID(),
        username: "Romina",
        favCategories: [.literature, .famousPeople, .philosophy]
    ),
    User(
        id: UUID(),
        username: "Oliver",
        favCategories: [.series, .games, .motivation]
    )
]

// Dummy Quotes
let dummyQuotes: [Quote] = [
    Quote(
        id: UUID(),
        authorName: "Albert Einstein",
        title: "Relativity",
        quote: "Time is relative.",
        categories: [.literature, .science, .philosophy],
        createdBy: dummyUsers[1] // Romina
    ),
    Quote(
        id: UUID(),
        authorName: "Yoda",
        title: "Star Wars",
        quote: "Do. Or do not. There is no try.",
        categories: [.movie, .motivation, .philosophy],
        createdBy: dummyUsers[0] // Jeff
    ),
    Quote(
        id: UUID(),
        authorName: "Geralt of Rivia",
        title: "The Witcher 3",
        quote: "Evil is evil. Lesser, greater, middling… makes no difference.",
        categories: [.games, .philosophy],
        createdBy: dummyUsers[2] // Oliver
    ),
    Quote(
        id: UUID(),
        authorName: "Michael Scott",
        title: "The Office",
        quote: "I am Beyoncé, always.",
        categories: [.series, .funny],
        createdBy: dummyUsers[2] // Oliver
    ),
    Quote(
        id: UUID(),
        authorName: "Freddie Mercury",
        title: "Queen",
        quote: "I won’t be a rock star. I will be a legend.",
        categories: [.music, .famousPeople, .motivation],
        createdBy: dummyUsers[0] // Jeff
    )
]
