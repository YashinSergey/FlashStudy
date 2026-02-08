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
            return []
        }

        return cards.isEmpty ? [] : cards
    }

    func saveCards(_ cards: [Flashcard]) {
        guard let data = try? JSONEncoder().encode(cards) else { return }
        UserDefaults.standard.set(data, forKey: cardsKey)
    }
}
