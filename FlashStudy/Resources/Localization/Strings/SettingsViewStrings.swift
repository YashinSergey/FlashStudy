//
//  SettingsViewStrings.swift
//  FlashStudy
//
//  Created by mr.Blue on 08.02.2026.
//

enum SettingsViewStrings: String, Localizable {
    
    /// Тема
    case appThemeTitle
    /// Оформление
    case appearenceTitle
    /// Настройки
    case settingsTitle
    /// Системная
    case systemTitle
    /// Светлая
    case lightTitle
    /// Темная
    case darkTitle

    var prefix: String? {
        "settingsView"
    }

    var tableName: String {
        "SettingsView"
    }
}
