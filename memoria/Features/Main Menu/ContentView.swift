//
//  ContentView.swift
//  memoria
//
//  Created by Song on 06/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var startGameSelected: Bool = false
    @EnvironmentObject var gameSettings: GameSettings
    @State var gameMode: GameMode = .easy
    
    var body: some View {
        ZStack {
            LottieView(fileName: "cloudAnimation").zIndex(0)

            VStack(spacing: startGameSelected == true ? 150 : 250) {
                Text("game.name").style(as: .title)

                if startGameSelected {
                    gameLevelOptions()
                        .transition(AnyTransition.opacity.combined(with: .scale(scale: 8)))
                        .zIndex(3)

                } else {
                    Button(action: {
                        withAnimation {
                            self.startGameSelected = true
                        }

                    }, label: {
                        Text("button.start_game").style(as: .start)
                            .frame(maxWidth: .infinity)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 1))
                            .padding([.leading, .trailing], 8)
                        }
                    ).transition(
                        AnyTransition.scale(scale: 8, anchor: .bottom)
                            .combined(with: .opacity)
                    ).zIndex(4)
                }
            }.zIndex(1)

            if gameSettings.presentGame {
                startGame()
                    .transition(.move(edge: .bottom))
                    .zIndex(2)
            }

        }.edgesIgnoringSafeArea(.all)
    }

    private func gameLevelOptions() -> some View {
        return AnyView(
            VStack(spacing: 16) {
                Button(action: {
                    withAnimation {
                        self.gameMode = .easy
                        self.gameSettings.presentGame.toggle()
                    }

                }, label: {
                    Text("button.easy_mode_game").style(as: .easyMode)
                        .frame(maxWidth: .infinity)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 1))
                        .padding([.leading, .trailing], 8)
                })
                Button(action: {
                    withAnimation {
                        self.gameMode = .normal
                        self.gameSettings.presentGame.toggle()
                    }

                }, label: {
                    Text("button.normal_mode_game").style(as: .normalMode)
                        .frame(maxWidth: .infinity)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.orange, lineWidth: 1))
                        .padding([.leading, .trailing], 8)
                })
                Button(action: {
                    withAnimation {
                        self.gameMode = .hard
                        self.gameSettings.presentGame.toggle()
                    }

                }, label: {
                    Text("button.hard_mode_game").style(as: .hardMode)
                        .frame(maxWidth: .infinity)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1))
                        .padding([.leading, .trailing], 8)
                })
            }
        )
    }

    private func startGame() -> some View {

        var seconds: Int = 0

        switch gameMode {
        case .easy:
            seconds = 120
        case .normal:
            seconds = 80
        case .hard:
            seconds = 45
        }

        return AnyView(
            GameView(
                gameMode: gameMode, seconds: seconds)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
