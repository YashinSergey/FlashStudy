//
//  AppViewModel.swift
//  FlashStudy
//
//  Created by mr.Blue on 15.02.2026.
//

import Foundation
import Combine

final class AppViewModel: ObservableObject {
    @Published private(set) var cards: [Flashcard]
    @Published var selectedTheme: AppTheme

    private let cardStore: FlashcardStoreProtocol
    private let themeStore: ThemeStoreProtocol

    init(cardStore: FlashcardStoreProtocol = FlashcardStore(), themeStore: ThemeStoreProtocol = ThemeStore()) {
        self.cardStore = cardStore
        self.themeStore = themeStore
        self.cards = cardStore.loadCards()
        self.selectedTheme = themeStore.loadTheme()
    }

    func addCard(front: String, back: String) {
        let card = Flashcard(frontText: front, backText: back)
        cards.append(card)
        saveCards()
    }

    func deleteCard(id: UUID) {
        cards.removeAll { $0.id == id }
        saveCards()
    }

    func updateCard(_ card: Flashcard) {
        guard let idx = cards.firstIndex(where: { $0.id == card.id }) else { return }
        cards[idx] = card
        saveCards()
    }

    func updateTheme(_ theme: AppTheme) {
        selectedTheme = theme
        themeStore.saveTheme(theme)
    }

    private func saveCards() {
        cardStore.saveCards(cards)
    }
}
