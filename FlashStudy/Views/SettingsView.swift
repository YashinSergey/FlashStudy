import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    let onThemeChange: (AppTheme) -> Void

    var body: some View {
        Form {
            Section(SettingsViewStrings.appThemeTitle.localized) {
                Picker(SettingsViewStrings.appearenceTitle.localized, selection: $viewModel.selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.title).tag(theme)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle(SettingsViewStrings.settingsTitle.localized)
        .onChange(of: viewModel.selectedTheme) { newTheme in
            onThemeChange(newTheme)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(viewModel: SettingsViewModel(selectedTheme: .system)) { _ in }
    }
}
