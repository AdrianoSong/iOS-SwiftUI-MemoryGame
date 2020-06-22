//
//  ButtonView+Extensions.swift
//  memoria
//
//  Created by Song on 11/06/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

extension Text {
    enum TextStyle {
        case title, start, easyMode, normalMode, hardMode, end
        case timer (foregroundColor: Color)
    }

    func style(as style: TextStyle) -> Text {

        switch style {
        case .title:
            return self.font(.system(size: 58, weight: .semibold)).foregroundColor(.memory)
        case .start:
            return self.font(.system(size: 58, weight: .semibold)).foregroundColor(.white)
        case .end:
            return self.font(.system(size: 38, weight: .semibold)).foregroundColor(.white)
        case .easyMode:
            return self.font(.system(size: 38, weight: .semibold)).foregroundColor(.green)
        case .normalMode:
            return self.font(.system(size: 38, weight: .semibold)).foregroundColor(.orange)
        case .hardMode:
            return self.font(.system(size: 38, weight: .semibold)).foregroundColor(.red)
        case .timer(let foregroundColor):
            return self.font(.system(size: 28, weight: .semibold)).foregroundColor(foregroundColor)
        }
    }
}
