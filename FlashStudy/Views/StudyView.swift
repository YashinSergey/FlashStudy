import SwiftUI

struct StudyView: View {
    @ObservedObject var coordinator: AppCoordinator
    @StateObject private var viewModel = StudyViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                if let card = viewModel.currentCard {
                    FlipCardView(frontText: card.frontText, backText: card.backText, isFlipped: $viewModel.isFlipped)

                    Text(viewModel.progressText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(StudyViewStrings.flipCardHint.localized)
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 12) {
                        Button(StudyViewStrings.previousBtnTitle.localized) {
                            withAnimation(.easeOut(duration: 0.2)) {
                                viewModel.goPrevious()
                            }
                        }
                        .buttonStyle(.bordered)
                        .disabled(!viewModel.canGoPrevious)

                        Button(StudyViewStrings.nextBtnTitle.localized) {
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
            .navigationTitle(StudyViewStrings.myFlashcards.localized)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
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

            /// Floating add button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        coordinator.showAddCard()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                    .frame(width: 56, height: 56)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "rectangle.stack.badge.plus")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)

            Text(StudyViewStrings.noCardsYetTitle.localized)
                .font(.headline)

            Text(StudyViewStrings.noCartdsYetSubtitle.localized)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button {
                coordinator.showAddCard()
            } label: {
                Text(StudyViewStrings.addFlashcardBtnTitle.localized)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 2)
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical)
        }
        .padding(.top, 60)
    }
}

#Preview {
    NavigationStack {
        StudyView(coordinator: AppCoordinator())
    }
}
