//
//  DebugWindow.swift
//  ___PROJECTNAME___
//
//  Created by Adriano Song on 4/2/20.
//

import UIKit
import SwiftUI

class SwiftUIDebugWindow: UIWindow {
    
    var appCoordinator: SwiftUIAppCoordinator?

    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        
        self.backgroundColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentDebug))
        tapGestureRecognizer.numberOfTouchesRequired = 2
        
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc func presentDebug() {
        guard let current = windowScene?.windows.first?.rootViewController else {
            return
        }

        current.present(UIHostingController(rootView: DebugMenuView()), animated: true, completion: nil)
    }
}
