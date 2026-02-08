import SwiftUI

enum AppTheme: String, CaseIterable, Codable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
            case .system: return SettingsViewStrings.systemTitle.localized
            case .light: return SettingsViewStrings.lightTitle.localized
            case .dark: return SettingsViewStrings.darkTitle.localized
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
            case .system: return nil
            case .light: return .light
            case .dark: return .dark
        }
    }
}
