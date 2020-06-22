//
//  GameView.swift
//  memoria
//
//  Created by Song on 11/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import SwiftUI

enum GameMode: String {
    case easy
    case normal
    case hard
}

struct GameView: View {

    var gameMode: GameMode
    var seconds: Int = 0

    private var viewModel: EmojiCardGameViewModel
    private var bidimensionalCards: [[Card<String>]]

    @ObservedObject private var gameTimer: GameTimer
    @EnvironmentObject var matchedPairs: MatchedPairs

    @State private var scale: CGFloat = 0

    init(gameMode: GameMode, seconds: Int) {

        self.gameMode = gameMode

        gameTimer = GameTimer(initTimer: seconds)

        viewModel = EmojiCardGameViewModel(gameMode: self.gameMode)

        bidimensionalCards = viewModel.toBidimensional()
    }

    var body: some View {

        ZStack {
            VStack {
                setupTimer().padding(.top, 30)
                createCards()
            }.zIndex(0)

            if youWin() {
                FinalScreen(title: "winner",
                            titleColor: .green,
                            description: "🥳",
                            buttonTitle: "close", animationFileName: "confetti")
                    .opacity(Double(scale))
                    .onAppear {
                        return withAnimation(Animation.easeInOut.delay(0.4)) {
                            self.matchedPairs.totalClicks = 99
                            self.scale = 1
                        }
                }.zIndex(1)

            } else if youLose() {
                FinalScreen(title: "end_game",
                            titleColor: .red,
                            description: "🤬",
                            buttonTitle: "try_again", animationFileName: "fire")
                    .opacity(Double(scale))
                    .onAppear {
                        return withAnimation(Animation.easeInOut.delay(0.4)) {
                            self.matchedPairs.totalClicks = 99
                            self.scale = 1
                        }
                    }
                    .zIndex(2)
            }

        }.background(Color.gameBackground)
    }

    private func setupTimer() -> some View {

        if gameTimer.isOver || youWin() {
            return AnyView(
                Text("00:00")
                    .style(as: .timer(foregroundColor: .primary)
                )
            )

        } else {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional

            return AnyView(
                Text("\(formatter.string(from: TimeInterval(gameTimer.timer)) ?? "00:00")")
                    .style(as: .timer(foregroundColor: gameTimer.timer > 60 ? .green : .red))
            )
        }
    }

    private func createCards() -> some View {
        return AnyView (
            GridStack(rows: viewModel.gridConfig.row, columns: viewModel.gridConfig.columns, content: { row, column in
                CardView(
                    cardFace: self.matchedPairs.pairs.contains(where:
                        { $0.id == self.bidimensionalCards[row][column].id}) == true ?
                            .up : .down,
                    cardContent: self.bidimensionalCards[row][column].content,
                    contentSize: self.viewModel.contentSize,
                    id: self.bidimensionalCards[row][column].id)
            })
        )
    }

    private func youWin() -> Bool {
        return viewModel.pairs == matchedPairs.pairs.count / 2
    }

    private func youLose() -> Bool {
        return gameTimer.isOver && !youWin()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameMode: .easy, seconds: 60)
    }
}
