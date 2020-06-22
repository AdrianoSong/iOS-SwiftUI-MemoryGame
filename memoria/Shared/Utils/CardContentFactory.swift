//
//  CardContentFactory.swift
//  memoria
//
//  Created by Song on 11/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

let emojis = ["👻", "👏", "🎃", "🥶", "👹", "😻", "👠", "🐭",
              "💼", "👛", "💍", "🐶", "🐳", "🦧", "🎹", "🎲",
              "🎯", "🎨", "🎳", "🎮", "🪕","🎤", "⛩", "💽",
              "💻", "📱", "⌚️", "☎️", "⏰", "📦", "📮", "📭",
              "📪", "❤️"
]

func emojiContentFactory(currentContents: [String]) -> String {

    var emoji = ""
    
    while true {
        emoji = emojis.randomElement() ?? "👻"
        if !currentContents.contains(emoji) {
            break
        }
    }

    return emoji
}
