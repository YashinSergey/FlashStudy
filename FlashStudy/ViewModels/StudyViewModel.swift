import Foundation

final class StudyViewModel: ObservableObject {
    @Published private(set) var currentIndex = 0
    @Published var isFlipped = false

    private var cards: [Flashcard] = []

    var hasCards: Bool { !cards.isEmpty }

    var currentCard: Flashcard? {
        guard cards.indices.contains(currentIndex) else { return nil }
        return cards[currentIndex]
    }

    var progressText: String {
        guard hasCards else { return "0 / 0" }
        return "\(currentIndex + 1) / \(cards.count)"
    }

    var canGoPrevious: Bool {
        currentIndex > 0
    }

    var canGoNext: Bool {
        currentIndex < cards.count - 1
    }

    func updateCards(_ cards: [Flashcard]) {
        let hadNoCardsBefore = self.cards.isEmpty
        self.cards = cards

        if cards.isEmpty {
            currentIndex = 0
            isFlipped = false
            return
        }

        if hadNoCardsBefore {
            currentIndex = 0
            isFlipped = false
            return
        }

        if currentIndex >= cards.count {
            currentIndex = max(0, cards.count - 1)
        }
    }

    func flipCard() {
        isFlipped.toggle()
    }

    func goNext() {
        guard canGoNext else { return }
        currentIndex += 1
        isFlipped = false
    }

    func goPrevious() {
        guard canGoPrevious else { return }
        currentIndex -= 1
        isFlipped = false
    }
}
