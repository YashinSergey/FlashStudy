import SwiftUI

struct AddCardView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var coordinator: AppCoordinator
    @StateObject private var viewModel = AddCardViewModel()

    var body: some View {
        Form {
            Section("Новая пара") {
                TextField("Слово или фраза (EN)", text: $viewModel.frontText)
                    .textInputAutocapitalization(.sentences)

                TextField("Перевод (RU)", text: $viewModel.backText)
                    .textInputAutocapitalization(.sentences)
            }

            if let validationMessage = viewModel.validationMessage {
                Section {
                    Text(validationMessage)
                        .foregroundStyle(.red)
                }
            }

            Section {
                Button("Сохранить") {
                    save()
                }
                .frame(maxWidth: .infinity)
                .disabled(!viewModel.canSave)
            }
        }
        .navigationTitle("Добавить")
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
