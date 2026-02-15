import SwiftUI

struct RootCoordinatorView: View {
    @StateObject private var appViewModel = AppViewModel()
    @StateObject private var coordinator: AppCoordinator
    @StateObject private var studyViewModel: StudyViewModel

    init() {
        let appVM = AppViewModel()
        _appViewModel = StateObject(wrappedValue: appVM)
        _coordinator = StateObject(wrappedValue: AppCoordinator(appViewModel: appVM))
        _studyViewModel = StateObject(wrappedValue: StudyViewModel(appViewModel: appVM))
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            StudyView(viewModel: studyViewModel, onOpenAddCard: {
                coordinator.showAddCard()
            }, onOpenSettings: {
                coordinator.showSettings()
            }, onDeleteCard: { id in
                appViewModel.deleteCard(id: id)
            })
            .navigationDestination(for: AppCoordinator.Route.self) { route in
                coordinator.destinationView(for: route)
            }
        }
        .preferredColorScheme(appViewModel.selectedTheme.colorScheme)
    }
}

#Preview {
    RootCoordinatorView()
}
