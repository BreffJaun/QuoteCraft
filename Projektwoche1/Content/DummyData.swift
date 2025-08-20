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
        categories: [.science, .philosophy, .famousPeople],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Yoda",
        title: "Star Wars",
        quote: "Do. Or do not. There is no try.",
        categories: [.movie, .motivation, .philosophy],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Geralt of Rivia",
        title: "The Witcher 3",
        quote: "Evil is evil. Lesser, greater, middling… makes no difference.",
        categories: [.games, .philosophy, .literature],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Michael Scott",
        title: "The Office",
        quote: "I am Beyoncé, always.",
        categories: [.series, .funny],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Freddie Mercury",
        title: "Queen",
        quote: "I won’t be a rock star. I will be a legend.",
        categories: [.music, .famousPeople, .motivation],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Socrates",
        title: "Wisdom",
        quote: "The only true wisdom is in knowing you know nothing.",
        categories: [.philosophy, .literature],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Aristotle",
        title: "Virtue",
        quote: "We are what we repeatedly do. Excellence, then, is not an act, but a habit.",
        categories: [.philosophy, .motivation],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Marcus Aurelius",
        title: "Meditations",
        quote: "You have power over your mind — not outside events. Realize this, and you will find strength.",
        categories: [.philosophy, .literature, .motivation],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Plato",
        title: "Justice",
        quote: "The measure of a man is what he does with power.",
        categories: [.philosophy, .famousPeople],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "William Shakespeare",
        title: "Hamlet",
        quote: "To be, or not to be, that is the question.",
        categories: [.literature, .philosophy],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Julius Caesar",
        title: "Veni Vidi Vici",
        quote: "I came, I saw, I conquered.",
        categories: [.history, .famousPeople, .motivation],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Oscar Wilde",
        title: "Life",
        quote: "Be yourself; everyone else is already taken.",
        categories: [.literature, .philosophy, .funny],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Friedrich Nietzsche",
        title: "Will to Power",
        quote: "That which does not kill us makes us stronger.",
        categories: [.philosophy, .motivation],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Confucius",
        title: "Wisdom",
        quote: "It does not matter how slowly you go as long as you do not stop.",
        categories: [.philosophy, .motivation, .literature],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Mahatma Gandhi",
        title: "Peace",
        quote: "Be the change that you wish to see in the world.",
        categories: [.philosophy, .famousPeople, .motivation],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Martin Luther King Jr.",
        title: "Dream",
        quote: "I have a dream.",
        categories: [.history, .famousPeople, .motivation],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "John Lennon",
        title: "Imagine",
        quote: "You may say I'm a dreamer, but I'm not the only one.",
        categories: [.music, .literature],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Steve Jobs",
        title: "Innovation",
        quote: "Stay hungry, stay foolish.",
        categories: [.famousPeople, .motivation, .technology],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Walt Disney",
        title: "Dream",
        quote: "All our dreams can come true, if we have the courage to pursue them.",
        categories: [.famousPeople, .motivation, .funny],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Nelson Mandela",
        title: "Freedom",
        quote: "It always seems impossible until it’s done.",
        categories: [.history, .motivation, .famousPeople],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Sun Tzu",
        title: "Art of War",
        quote: "Appear at points which the enemy must hasten to defend; march swiftly to places where you are not expected.",
        categories: [.philosophy, .literature, .history],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Leonardo da Vinci",
        title: "Creativity",
        quote: "Simplicity is the ultimate sophistication.",
        categories: [.art, .philosophy, .famousPeople],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "J.R.R. Tolkien",
        title: "Lord of the Rings",
        quote: "Not all those who wander are lost.",
        categories: [.literature, .fantasy, .philosophy],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "George R.R. Martin",
        title: "Game of Thrones",
        quote: "A reader lives a thousand lives before he dies. The man who never reads lives only one.",
        categories: [.literature, .fantasy, .series],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Harry Potter",
        title: "Dumbledore",
        quote: "Happiness can be found even in the darkest of times, if one only remembers to turn on the light.",
        categories: [.literature, .fantasy, .movie],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "The Joker",
        title: "Dark Knight",
        quote: "Why so serious?",
        categories: [.movie, .funny, .series],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Captain Picard",
        title: "Star Trek",
        quote: "Make it so.",
        categories: [.series, .science, .famousPeople],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Master Chief",
        title: "Halo",
        quote: "I need a weapon.",
        categories: [.games, .scienceFiction],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Ellie",
        title: "The Last of Us",
        quote: "When you're lost in the darkness, look for the light.",
        categories: [.games, .motivation, .philosophy],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Kratos",
        title: "God of War",
        quote: "The cycle ends here. We must be better.",
        categories: [.games, .philosophy, .motivation],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Cloud Strife",
        title: "Final Fantasy VII",
        quote: "No one lives in the slums because they want to. It’s like this train. It can’t run anywhere except where its tracks take it.",
        categories: [.games, .literature, .fantasy],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Gandalf",
        title: "The Lord of the Rings",
        quote: "All we have to decide is what to do with the time that is given us.",
        categories: [.literature, .fantasy, .movie, .philosophy],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Batman",
        title: "The Dark Knight",
        quote: "It’s not who I am underneath, but what I do that defines me.",
        categories: [.movie, .series, .motivation, .philosophy],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Spock",
        title: "Star Trek",
        quote: "Logic is the beginning of wisdom, not the end.",
        categories: [.series, .science, .philosophy],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Tony Stark",
        title: "Iron Man",
        quote: "Sometimes you gotta run before you can walk.",
        categories: [.movie, .technology, .motivation],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Rocky Balboa",
        title: "Rocky",
        quote: "It ain’t about how hard you hit. It’s about how hard you can get hit and keep moving forward.",
        categories: [.movie, .motivation, .philosophy],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Forrest Gump",
        title: "Forrest Gump",
        quote: "Life is like a box of chocolates. You never know what you’re gonna get.",
        categories: [.movie, .funny, .literature],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Darth Vader",
        title: "Star Wars",
        quote: "I find your lack of faith disturbing.",
        categories: [.movie, .scienceFiction, .series],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Thanos",
        title: "Avengers",
        quote: "I am inevitable.",
        categories: [.movie, .scienceFiction],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Iron Man",
        title: "Endgame",
        quote: "I am Iron Man.",
        categories: [.movie, .scienceFiction, .famousPeople],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Captain America",
        title: "Avengers",
        quote: "I can do this all day.",
        categories: [.movie, .series, .motivation],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Joker",
        title: "Joker",
        quote: "Is it just me, or is it getting crazier out there?",
        categories: [.movie, .funny, .philosophy],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Vito Corleone",
        title: "The Godfather",
        quote: "I’m gonna make him an offer he can’t refuse.",
        categories: [.movie, .famousPeople, .literature],
        createdBy: dummyUsers[2]
    ),
    Quote(
        id: UUID(),
        authorName: "Tywin Lannister",
        title: "Game of Thrones",
        quote: "Any man who must say 'I am the king' is no true king.",
        categories: [.series, .literature, .fantasy],
        createdBy: dummyUsers[0]
    ),
    Quote(
        id: UUID(),
        authorName: "Tyrion Lannister",
        title: "Game of Thrones",
        quote: "I drink and I know things.",
        categories: [.series, .funny, .fantasy],
        createdBy: dummyUsers[1]
    ),
    Quote(
        id: UUID(),
        authorName: "Walter White",
        title: "Breaking Bad",
        quote: "I am the one who knocks!",
        categories: [.series, .famousPeople, .motivation],
        createdBy: dummyUsers[2]
    )
]
