//
//  LottieView.swift
//  memoria
//
//  Created by Song on 11/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    typealias UIViewType = UIView
    var fileName: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {

        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)

        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
