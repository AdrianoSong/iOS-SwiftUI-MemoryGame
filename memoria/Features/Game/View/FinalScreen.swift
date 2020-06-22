//
//  FinalScreen.swift
//  memoria
//
//  Created by Song on 17/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct FinalScreen: View {

    var title: LocalizedStringKey
    var titleColor: Color
    var description: String
    var buttonTitle: LocalizedStringKey
    var animationFileName: String

    @EnvironmentObject var gameSettings: GameSettings
    @EnvironmentObject var matchedPairs: MatchedPairs

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 45, weight: .semibold))
                .foregroundColor(titleColor)

            Text(description)
                .font(.system(size: 45, weight: .semibold))

            LottieView(fileName: animationFileName)
                .frame(width: 150, height: 150, alignment: .center)

            Button(action: {
                withAnimation{
                    self.matchedPairs.pairs = []
                    self.matchedPairs.totalClicks = 0
                    self.gameSettings.presentGame.toggle()
                }

            }, label: {
                Text(buttonTitle).style(as: .end)
                    .frame(maxWidth: .infinity)
                    .background(titleColor)
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 8)
            })
        }.background(Color.clear)
    }
}

struct FinalScreen_Previews: PreviewProvider {
    static var previews: some View {
        FinalScreen(title: "winner",
                    titleColor: .orange,
                    description: "🤪",
                    buttonTitle: "winner",
                    animationFileName: "confetti")
    }
}
