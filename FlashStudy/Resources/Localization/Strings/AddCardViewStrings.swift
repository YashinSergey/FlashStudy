//
//  AddCardViewStrings.swift
//  FlashStudy
//
//  Created by mr.Blue on 08.02.2026.
//

enum AddCardViewStrings: String, Localizable {
    
    /// Новая пара
    case newPair
    /// Добавить карточку
    case addFlashcardTitle
    /// Сохранить
    case saveButtonTitle
    /// Лицевая сторона
    case frontSideRowHint
    /// Обратная сторона
    case backSideRowHint
    
    var prefix: String? {
        "addCardView"
    }

    var tableName: String {
        "AddCardView"
    }
}
