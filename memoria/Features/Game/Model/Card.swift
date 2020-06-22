//
//  Card.swift
//  memoria
//
//  Created by Song on 11/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct Card<T>: Identifiable {
    let id = UUID()
    var cardFace: CardFace
    var isMatched: Bool = false
    var content: T
    var contentSize: CGFloat = 85
}
