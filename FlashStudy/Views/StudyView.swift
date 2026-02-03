import SwiftUI

struct StudyView: View {
    @ObservedObject var coordinator: AppCoordinator
    @StateObject private var viewModel = StudyViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if let card = viewModel.currentCard {
                FlipCardView(frontText: card.frontText, backText: card.backText, isFlipped: $viewModel.isFlipped)

                Text(viewModel.progressText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("Нажмите на карточку, чтобы перевернуть")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                HStack(spacing: 12) {
                    Button("Предыдущая") {
                        withAnimation(.easeOut(duration: 0.2)) {
                            viewModel.goPrevious()
                        }
                    }
                    .buttonStyle(.bordered)
                    .disabled(!viewModel.canGoPrevious)

                    Button("Следующая") {
                        withAnimation(.easeOut(duration: 0.2)) {
                            viewModel.goNext()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.canGoNext)
                }
            } else {
                emptyState
            }

            Spacer()
        }
        .padding(.top, 12)
        .navigationTitle("Учеба")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    coordinator.showAddCard()
                } label: {
                    Image(systemName: "plus")
                }

                Button {
                    coordinator.showSettings()
                } label: {
                    Image(systemName: "gearshape")
                }
            }
        }
        .onAppear { viewModel.updateCards(coordinator.cards) }
        .onReceive(coordinator.$cards) { cards in
            viewModel.updateCards(cards)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "rectangle.stack.badge.plus")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)

            Text("Пока нет карточек")
                .font(.headline)

            Text("Добавьте первую пару слово/перевод")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button("Добавить карточку") {
                coordinator.showAddCard()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.top, 60)
    }
}

#Preview {
    NavigationStack {
        StudyView(coordinator: AppCoordinator())
    }
}
