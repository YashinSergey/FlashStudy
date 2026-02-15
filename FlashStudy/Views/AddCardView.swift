import SwiftUI

struct AddCardView: View {
    @ObservedObject var viewModel: AddCardViewModel
    let onSave: (_ front: String, _ back: String) -> Void
    let onCancel: () -> Void

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
        onSave(values.front, values.back)
        viewModel.reset()
    }
}

#Preview {
    NavigationStack {
        AddCardView(viewModel: AddCardViewModel(), onSave: { _, _ in }, onCancel: { })
    }
}
