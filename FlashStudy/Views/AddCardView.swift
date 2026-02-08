import SwiftUI

struct AddCardView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var coordinator: AppCoordinator
    @StateObject private var viewModel = AddCardViewModel()

    var body: some View {
        Form {
            Section(AddCardViewStrings.newPair.localized) {
                TextField(AddCardViewStrings.frontSideRowHint.localized, text: $viewModel.frontText)
                    .textInputAutocapitalization(.sentences)

                TextField(AddCardViewStrings.backSideRowHint.localized, text: $viewModel.backText)
                    .textInputAutocapitalization(.sentences)
            }

            if let validationMessage = viewModel.validationMessage {
                Section {
                    Text(validationMessage)
                        .foregroundStyle(.red)
                }
            }

            Section {
                Button(AddCardViewStrings.saveButtonTitle.localized) {
                    save()
                }
                .frame(maxWidth: .infinity)
                .disabled(!viewModel.canSave)
            }
        }
        .navigationTitle(AddCardViewStrings.addFlashcardTitle.localized)
    }

    private func save() {
        guard let values = viewModel.normalizedValues() else { return }
        coordinator.addCard(front: values.front, back: values.back)
        viewModel.reset()
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddCardView(coordinator: AppCoordinator())
    }
}
