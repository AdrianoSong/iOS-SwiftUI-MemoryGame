//
//  CardView.swift
//  memoria
//
//  Created by Song on 06/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import SwiftUI

enum CardFace {
    case up
    case down
}

struct CardView<T: StringProtocol>: View {

    var cardFace: CardFace
    var cardContent: T
    var contentSize: CGFloat = 85
    var id: UUID

    @State var rotationAmount: Double = 0.0
    @EnvironmentObject var matchedPairs: MatchedPairs

    var body: some View {
        ZStack {
            showCard().onTapGesture(count: 1) {
                if self.matchedPairs.totalClicks < 2 {
                    self.updateCardRotation()
                    self.checkPair()

                    self.matchedPairs.totalClicks += 1
                }
            }
            .rotation3DEffect(.degrees(rotationAmount), axis: (x: 1, y: 1, z: 0))
            .animation(Animation.easeOut(duration: 0.45))

        }.padding(.all, 4)
    }

    func showCard() -> some View {
        switch cardFace {
        case .down:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 5)
                        .foregroundColor(Color.orange)
                        .background(Color.memory)

                    Text("🃏")
                        .font(.system(size: contentSize, weight: .semibold))
                }
            )
        case .up:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 5)
                    .foregroundColor(Color.orange)
                    .background(Color.white)

                    Text(cardContent)
                        .font(.system(size: contentSize, weight: .semibold))
                }
            )
        }
    }

    /**
     Checkpairs
     1 - if there is no pairs been counted more than once
     2 - if there is a item that can matches with new one
     3 - if there is a item with no matches add new with no match and remove those 2 after 1 second
     4 - else add new item to stack, for wait new validation
     */
    private func checkPair() {

        guard let currentContent = cardContent as? String else {
            return
        }

        if matchedPairs.pairs.contains(where: {$0.content == currentContent && $0.id == id}) {
            matchedPairs.totalClicks = 0

        } else if matchedPairs.pairs.contains(where: {$0.content == currentContent && $0.id != id}) {
            matchedPairs.pairs.first(where: {$0.content == currentContent})?.match = true
            matchedPairs.pairs.append(Matched(id: id, content: currentContent, match: true))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.matchedPairs.totalClicks = 0
            })

        } else if matchedPairs.pairs.contains(where: {$0.match == false}) {
            matchedPairs.pairs.append(Matched(id: id, content: currentContent, match: false))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.matchedPairs.pairs.removeAll(where: {$0.match == false})
                self.matchedPairs.totalClicks = 0
            })

        } else {
            matchedPairs.pairs.append(Matched(id: id, content: currentContent, match: false))
            matchedPairs.totalClicks = 0
        }
    }

    private func updateCardRotation() {
        withAnimation {
            rotationAmount += 360
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardFace: .up, cardContent: "👻", id: UUID())
    }
}
