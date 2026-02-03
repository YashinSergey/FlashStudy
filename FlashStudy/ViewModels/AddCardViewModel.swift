import Foundation

final class AddCardViewModel: ObservableObject {
    @Published var frontText = ""
    @Published var backText = ""
    @Published var validationMessage: String?

    var canSave: Bool {
        !frontText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !backText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func normalizedValues() -> (front: String, back: String)? {
        let front = frontText.trimmingCharacters(in: .whitespacesAndNewlines)
        let back = backText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !front.isEmpty, !back.isEmpty else {
            validationMessage = "Заполните оба поля"
            return nil
        }

        validationMessage = nil
        return (front, back)
    }

    func reset() {
        frontText = ""
        backText = ""
        validationMessage = nil
    }
}
