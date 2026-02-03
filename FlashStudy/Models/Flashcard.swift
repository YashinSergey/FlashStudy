import Foundation

struct Flashcard: Identifiable, Codable, Hashable {
    let id: UUID
    let frontText: String
    let backText: String

    init(id: UUID = UUID(), frontText: String, backText: String) {
        self.id = id
        self.frontText = frontText
        self.backText = backText
    }
}
