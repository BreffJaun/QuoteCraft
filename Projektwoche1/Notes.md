#  QuoteCraft


## Main Views (TabViewBar)

- HomeView 
    - => Zitat anzeigen bei App-Start
    - => Bei jedem App-Start wird ein neues, zufälliges Zitat angezeigt.
    - => Zusätzlicher Button zum Aktualisieren
    - 
    
    
- QuotesView
    - => Alle quotes
    - => SwipeAction: Button zum Favorisieren
    - => Neuen Quote erstellen
    
- FavoritesView
    - => Anzeige für Favoriten
    - => SwipeAction: Button zum Favorisieren

- CategoryView
    - => SwipeAction: Button zum Entfavorisieren
    - => 

## SubViews

- QuoteDetailView 
    - View zum Anzeigen eines Zitats mit Autor:in
- Sheet: zum Anlegen neuer Quotes
    - Favoriten in SwiftData speichern
    
## Enums

- Kategorien erstellen, um Zitate daraus anzuzeigen
- Hintergrundfarben für Kategorien der Zitate

- Category 
enum Category: String, CaseIterable {
    case movie        // Zitate aus Filmen
    case series       // Zitate aus Serien
    case literature   // Zitate aus Büchern / Gedichten
    case music        // Songtexte / Songzitate
    case famousPeople // Zitate von realen Persönlichkeiten (z.B. Albert Einstein)
    case games        // Zitate aus Videospielen
    case miscellaneous // Sonstige / nicht klassifizierbare Zitate
}

## Models

- Quote
    - id: UUID
    - authorName: String => Name des Zitat-Autors (z.b. Albert Einstein) 
    - title: String
    - quote: String
    - category: Category
    - @Relationship var createdBy: User (username) => Der User der das Zitat eingestellt hat

- User
    - id: UUID
    - username: String
    - @Relationship var favorites: [Quote]
    - @Relationship var quotes: [Quote] => Zitate die der user eingestellt/erstellt hat


## Optional

- DataManager
- Sucher per TextField
- Zitat als Bild teilen
- Bewertungsystem
