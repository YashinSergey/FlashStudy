import SwiftUI

struct RootCoordinatorView: View {
    @StateObject var coordinator = AppCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            StudyView(coordinator: coordinator)
                .navigationDestination(for: AppCoordinator.Route.self) { route in
                    switch route {
                    case .addCard:
                        AddCardView(coordinator: coordinator)
                    case .settings:
                        SettingsView(coordinator: coordinator)
                    }
                }
        }
        .preferredColorScheme(coordinator.selectedTheme.colorScheme)
    }
}

#Preview {
    RootCoordinatorView()
}
