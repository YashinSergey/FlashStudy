//
//  Localizable.swift
//  FlashStudy
//
//  Created by mr.Blue on 08.02.2026.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
    /// Use for generate dictionary key `prefix.rawValue`
    var prefix: String? { get }
    var localized: String { get }
    func localized(_ param: CVarArg...) -> String
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    var prefix: String? {
        nil
    }
    
    var tableName: String {
        "Localizable"
    }
    
    var key: String {
        let keyName = String(reflecting: self).split(separator: ".").last ?? ""
        if String(keyName) == rawValue {
            return prefix == nil ? rawValue : "\(prefix!).\(rawValue)"
        } else {
            return rawValue
        }
    }
    
    func localized(_ param: CVarArg...) -> String {
        let format = self.localized
        return String(format: format, arguments: param)
    }
    
    var localized: String {
        let result = Bundle.main.localizedString(forKey: key, value: nil, table: tableName)
        return result != key ? result : defaultLocalized
    }
    
    private var defaultLocalized: String {
        /// Trying to find english localization
        if let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
           let bundle = Bundle(path: path) {
            let result = bundle.localizedString(forKey: key,
                                               value: "**\(key)**",
                                               table: tableName)
            if result != "**\(key)**" {
                return result
            }
        }
        
        /// If the English localization is not found, return the key.
        return "**\(key)**"
    }
}
