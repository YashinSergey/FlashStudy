import Foundation
import SwiftUI

final class ThemeRepository: ObservableObject {
    @Published var selectedTheme: AppTheme

    private let store: ThemeStoreProtocol

    init(store: ThemeStoreProtocol = ThemeStore()) {
        self.store = store
        self.selectedTheme = store.loadTheme()
    }

    func updateTheme(_ theme: AppTheme) {
        selectedTheme = theme
        store.saveTheme(theme)
    }
}
