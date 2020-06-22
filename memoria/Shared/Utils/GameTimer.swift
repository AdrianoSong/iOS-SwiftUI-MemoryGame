//
//  GameTimer.swift
//  memoria
//
//  Created by Song on 15/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

class GameTimer: ObservableObject {

    @Published var timer: Int
    @Published var isOver: Bool = false

    init(initTimer: Int) {
        self.timer = initTimer

        let countdown = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(runTimer),
            userInfo: nil,
            repeats: true
        )

        countdown.tolerance = 0.2

        RunLoop.current.add(countdown, forMode: .default)
    }

    @objc
    private func runTimer() {
        timer -= 1
        
        if  timer <= 0 {
            isOver = true
        }
    }
}
