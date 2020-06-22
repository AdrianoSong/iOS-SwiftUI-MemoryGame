//
//  Coordinator.swift
//  ___PROJECTNAME___
//
//  Created by Adriano Song on 4/2/20.
//
import UIKit
import SwiftUI
import AVFoundation

class SwiftUIAppCoordinator: Coordinator {
    
    var window: UIWindow?

    var matchedPairs: MatchedPairs
    var gameSettings: GameSettings

    var gameSound: AVAudioPlayer?

    init(window: UIWindow?) {
        self.window = window
        matchedPairs = MatchedPairs()
        gameSettings = GameSettings()

        configGameSound()
    }

    private func configGameSound() {

        guard let songPath = Bundle.main.path(
            forResource: "Mozart_Le nozze di Figaro.mp3", ofType: nil) else {
            return
        }

        let url = URL(fileURLWithPath: songPath)

        gameSound = try? AVAudioPlayer(contentsOf: url)
        gameSound?.numberOfLoops = 99
        gameSound?.play()
    }

    func start() {

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
            .environmentObject(matchedPairs)
            .environmentObject(gameSettings)

        window?.rootViewController = UIHostingController(rootView: contentView)
    }

    func finish() {
        //TODO implement here
    }
}
