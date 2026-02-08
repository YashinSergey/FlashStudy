//
//  AlertMessagesStrings.swift
//  FlashStudy
//
//  Created by mr.Blue on 08.02.2026.
//

enum AlertMessageStrings: String, Localizable {
    
    /// Заполните оба поля
    case fillBothFields
    
    var prefix: String? {
        "alertMessage"
    }

    var tableName: String {
        "AlertMessage"
    }
}
