import Foundation

protocol ThemeStoreProtocol {
    func loadTheme() -> AppTheme
    func saveTheme(_ theme: AppTheme)
}

final class ThemeStore: ThemeStoreProtocol {
    private let themeKey = "app.theme"

    func loadTheme() -> AppTheme {
        guard
            let rawValue = UserDefaults.standard.string(forKey: themeKey),
            let theme = AppTheme(rawValue: rawValue)
        else {
            return .system
        }

        return theme
    }

    func saveTheme(_ theme: AppTheme) {
        UserDefaults.standard.set(theme.rawValue, forKey: themeKey)
    }
}
