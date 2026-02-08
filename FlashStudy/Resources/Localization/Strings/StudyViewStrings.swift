//
//  Untitled.swift
//  FlashStudy
//
//  Created by mr.Blue on 08.02.2026.
//

enum StudyViewStrings: String, Localizable {
    
    /// У вас пока нет карточек
    case noCardsYetTitle
    /// Создайте первую карточку
    case noCartdsYetSubtitle
    /// Добавить карточку
    case addFlashcardBtnTitle
    /// Мои карточки
    case myFlashcards
    /// Следующая
    case nextBtnTitle
    /// Предыдущая
    case previousBtnTitle
    /// Нажмите на карточку, чтобы ее перевернуть
    case flipCardHint
    
    var prefix: String? {
        "studyView"
    }

    var tableName: String {
        "StudyView"
    }
}
