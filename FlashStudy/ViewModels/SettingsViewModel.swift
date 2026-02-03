import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: AppTheme

    init(selectedTheme: AppTheme) {
        self.selectedTheme = selectedTheme
    }
}
