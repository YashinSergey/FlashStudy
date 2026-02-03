import Foundation

protocol FlashcardStoreProtocol {
    func loadCards() -> [Flashcard]
    func saveCards(_ cards: [Flashcard])
}

final class FlashcardStore: FlashcardStoreProtocol {
    private let cardsKey = "flashcards.storage"

    func loadCards() -> [Flashcard] {
        guard
            let data = UserDefaults.standard.data(forKey: cardsKey),
            let cards = try? JSONDecoder().decode([Flashcard].self, from: data)
        else {
            return Self.defaultCards
        }

        return cards.isEmpty ? Self.defaultCards : cards
    }

    func saveCards(_ cards: [Flashcard]) {
        guard let data = try? JSONEncoder().encode(cards) else { return }
        UserDefaults.standard.set(data, forKey: cardsKey)
    }

    private static var defaultCards: [Flashcard] {
        [
            Flashcard(frontText: "Hello", backText: "Привет"),
            Flashcard(frontText: "Thank you", backText: "Спасибо"),
            Flashcard(frontText: "How are you?", backText: "Как дела?")
        ]
    }
}
