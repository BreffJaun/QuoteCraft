//
//  DummData.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation

let dummyUsers: [User] = [
    User(
        id: UUID(),
        username: "Jeff",
        favCategories: [.movie, .music]
    ),
    User(
        id: UUID(),
        username: "Romina",
        favCategories: [.literature, .famousPeople]
    ),
    User(
        id: UUID(),
        username: "Oliver",
        favCategories: [.series, .games]
    )
]


let dummyQuotes: [Quote] = [
    Quote(
        id: UUID(),
        authorName: "Albert Einstein",
        title: "Relativity",
        quote: "Time is relative.",
        category: .literature,
        createdBy: dummyUsers[1] // Romina
    ),
    Quote(
        id: UUID(),
        authorName: "Yoda",
        title: "Star Wars",
        quote: "Do. Or do not. There is no try.",
        category: .movie,
        createdBy: dummyUsers[0] // Jeff
    ),
    Quote(
        id: UUID(),
        authorName: "Geralt of Rivia",
        title: "The Witcher 3",
        quote: "Evil is evil. Lesser, greater, middling… makes no difference.",
        category: .games,
        createdBy: dummyUsers[2] // Oliver
    ),
    Quote(
        id: UUID(),
        authorName: "Michael Scott",
        title: "The Office",
        quote: "I am Beyoncé, always.",
        category: .series,
        createdBy: dummyUsers[2] // Oliver
    ),
    Quote(
        id: UUID(),
        authorName: "Freddie Mercury",
        title: "Queen",
        quote: "I won’t be a rock star. I will be a legend.",
        category: .music,
        createdBy: dummyUsers[0] // Jeff
    )
]
