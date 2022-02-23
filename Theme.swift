//
//  Theme.swift
//  Concentration_Lecture_1
//
//  Created by Rona Bompa on 22.02.2022.
//

import Foundation
import UIKit

struct Theme {
    private(set) var emojis: [String]
    private(set) var name: String
    private(set) var cardBackgroundColor: UIColor

    init(emojis: [String], name: String, cardBackgroundColor: UIColor) {
        self.emojis = emojis
        self.name = name
        self.cardBackgroundColor = cardBackgroundColor
    }
//
//    init() {
//        emojis =  ["🎻","🎹","🎷", "🎺", "🎸", "🪕", "🪘" ,"🎤","🎼","🪗"]
//        name = "Music"
//        cardBackgroundColor = UIColor.orange
//    }

}
