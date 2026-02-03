import SwiftUI

struct SettingsView: View {
    @ObservedObject var coordinator: AppCoordinator
    @StateObject private var viewModel: SettingsViewModel

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        _viewModel = StateObject(wrappedValue: SettingsViewModel(selectedTheme: coordinator.selectedTheme))
    }

    var body: some View {
        Form {
            Section("Тема") {
                Picker("Оформление", selection: $viewModel.selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.title).tag(theme)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section {
                Text("Тема применяется сразу для всего приложения.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Настройки")
        .onChange(of: viewModel.selectedTheme) { newTheme in
            coordinator.updateTheme(newTheme)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(coordinator: AppCoordinator())
    }
}
