//
//  GameViewModel.swift
//  memoria
//
//  Created by Song on 11/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiCardGameViewModel {
    var cards: [Card<String>]
    var pairs = 0
    var gridConfig: (row: Int, columns: Int) = (0, 0)
    var contentSize: CGFloat = 0

    init(gameMode: GameMode) {

        switch gameMode {
        case .easy:
            pairs = 4
            gridConfig = (4, 2)
            contentSize = 85
        case .normal:
            pairs = 8
            gridConfig = (4, 4)
            contentSize = 50
        case .hard:
            pairs = 12
            gridConfig = (6, 4)
            contentSize = 35
        }

        cards = []

        for _ in 0..<pairs {
            let content = emojiContentFactory(
                currentContents: cards.map {$0.content})
            cards.append(Card(cardFace: .down, content: content))
            cards.append(Card(cardFace: .down, content: content))
        }
    }

    func toBidimensional() -> [[Card<String>]] {

        cards.shuffle()

        var count = 0
        var copieCards = cards
        var auxArray: [Card<String>] = []
        var returnd: [[Card<String>]] = []

        while !copieCards.isEmpty {
            while count < gridConfig.columns {
                auxArray.append(copieCards.removeFirst())
                count += 1
            }
            returnd.append(auxArray)
            auxArray = []
            count = 0
        }

        return returnd
    }
}
