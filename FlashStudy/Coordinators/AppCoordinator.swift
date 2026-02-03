import SwiftUI

final class AppCoordinator: ObservableObject {
    enum Route: Hashable {
        case addCard
        case settings
    }

    @Published var path = NavigationPath()
    @Published private(set) var cards: [Flashcard]
    @Published var selectedTheme: AppTheme {
        didSet { themeStore.saveTheme(selectedTheme) }
    }

    private let cardStore: FlashcardStoreProtocol
    private let themeStore: ThemeStoreProtocol

    init(cardStore: FlashcardStoreProtocol = FlashcardStore(), themeStore: ThemeStoreProtocol = ThemeStore()) {
        self.cardStore = cardStore
        self.themeStore = themeStore
        self.cards = cardStore.loadCards()
        self.selectedTheme = themeStore.loadTheme()
    }

    func showAddCard() {
        path.append(Route.addCard)
    }

    func showSettings() {
        path.append(Route.settings)
    }

    func addCard(front: String, back: String) {
        let card = Flashcard(frontText: front, backText: back)
        cards.append(card)
        cardStore.saveCards(cards)
    }

    func updateTheme(_ theme: AppTheme) {
        selectedTheme = theme
    }
}
