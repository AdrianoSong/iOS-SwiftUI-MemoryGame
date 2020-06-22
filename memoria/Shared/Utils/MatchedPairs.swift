//
//  MatchedPairs.swift
//  memoria
//
//  Created by Song on 17/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

class Matched {
    let id: UUID
    let content: String
    var match: Bool

    init(id: UUID, content: String, match: Bool) {
        self.id = id
        self.content = content
        self.match = match
    }
}

class MatchedPairs: ObservableObject {

    @Published var pairs: [Matched] = []
    @Published var totalClicks: Int = 0

    func isEmpty() -> Bool {
        return pairs.isEmpty
    }
}
