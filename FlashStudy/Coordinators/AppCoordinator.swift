import SwiftUI

final class AppCoordinator: ObservableObject {
    enum Route: Hashable {
        case addCard
        case settings
    }

    @Published var path = NavigationPath()

    private let appViewModel: AppViewModel

    init(appViewModel: AppViewModel) {
        self.appViewModel = appViewModel
    }

    func showAddCard() {
        path.append(Route.addCard)
    }

    func showSettings() {
        path.append(Route.settings)
    }

    func pop() {
        path.removeLast()
    }

    @ViewBuilder
    func destinationView(for route: Route) -> some View {
        switch route {
            case .addCard:
                // Build AddCardViewModel and pass callbacks
                let vm = AddCardViewModel()
                AddCardView(viewModel: vm) {
                    [weak self] front, back in
                    self?.appViewModel.addCard(front: front, back: back)
                    self?.pop()
                } onCancel: { [weak self] in
                    self?.pop()
                }

            case .settings:
                let vm = SettingsViewModel(selectedTheme: appViewModel.selectedTheme)
                SettingsView(viewModel: vm) { [weak self] newTheme in
                    self?.appViewModel.updateTheme(newTheme)
                }
        }
    }
}
