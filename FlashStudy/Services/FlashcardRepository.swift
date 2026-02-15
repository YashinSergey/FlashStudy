import Foundation

final class FlashcardRepository: ObservableObject {
    @Published private(set) var cards: [Flashcard] = []

    private let store: FlashcardStoreProtocol

    init(store: FlashcardStoreProtocol = FlashcardStore()) {
        self.store = store
        self.cards = store.loadCards()
    }

    func addCard(front: String, back: String) {
        let card = Flashcard(frontText: front, backText: back)
        cards.append(card)
        save()
    }

    func deleteCard(id: UUID) {
        cards.removeAll { $0.id == id }
        save()
    }

    func updateCard(_ card: Flashcard) {
        guard let idx = cards.firstIndex(where: { $0.id == card.id }) else { return }
        cards[idx] = card
        save()
    }

    private func save() {
        store.saveCards(cards)
    }
}
