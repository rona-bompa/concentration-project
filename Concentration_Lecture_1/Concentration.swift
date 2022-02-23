//
//  Concentration.swift
//  Concentration_Lecture_1
//
//  Created by Rona Bompa on 18.02.2022.
//

import Foundation
import UIKit

final class Concentration {

    var themes = [
        Theme(emojis: ["🎻","🎹","🎷", "🎺", "🎸", "🪕", "🪘" ,"🎤","🎼","🪗"], name: "Music", cardBackgroundColor: UIColor.orange),
        Theme(emojis: ["🏀","⚽️","🥎", "🏐", "🏓", "🎱", "🏉" ,"🏸","🥊","🏹"], name: "Sports", cardBackgroundColor: UIColor.blue),
        Theme(emojis: ["🍎","🫐","🍉", "🍇", "🍍", "🥝", "🥥" ,"🍒","🍋","🍊"], name: "Fruits", cardBackgroundColor: UIColor.yellow),
        Theme(emojis: ["🧄","🌶","🍅", "🥒", "🥬", "🥦", "🥕" ,"🫒","🥔","🧅"], name: "Vegetables", cardBackgroundColor: UIColor.green),
        Theme(emojis: ["👘","👠","👢", "👔", "👞", "👒", "🪡" ,"🧵","👗","👛"], name: "Fashion", cardBackgroundColor: UIColor.red),
        Theme(emojis: ["🦁","🐰","🐨", "🐔", "🦊", "🐻", "🐒" ,"🐴","🐢","🐬"], name: "Animals", cardBackgroundColor: UIColor.brown)
    ]

    var cards = [Card]()
    var theme: Theme

    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    var historyOfCardChoises = [Int:Int]() // identifier si de cate ori a aparut

    init(numberOfPairOfCards: Int) {
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        self.theme = themes[Int(arc4random_uniform(UInt32(themes.count)))]
    }

    func choseCard(at currIndex: Int) {
        flipCount += 1

        // gonna igonre all the matched cards
        if !cards[currIndex].isMatched {

            // case A) 1 card is already face up
            if let prevIndex = indexOfOneAndOnlyFaceUpCard, prevIndex != currIndex {
                // check if the chosen card matches with the card that is already face up
                if cards[prevIndex].identifier == cards[currIndex].identifier {
                    cards[prevIndex].isMatched = true
                    cards[currIndex].isMatched = true
                    score += 2
                } else {
                    // if the emoji was not seen (is nil), we add it to the dictionary
                    if(historyOfCardChoises[cards[currIndex].identifier] == nil){
                        historyOfCardChoises[cards[currIndex].identifier] = 0
                    } else {
                    // if not nil, then we mark it as seen again
                        historyOfCardChoises[cards[currIndex].identifier]! += 1
                        score -= 1
                    }
                    // if the previous was seen, penalty -1
                    if let history = historyOfCardChoises[cards[prevIndex].identifier], history > 0 {
                        score -= 1
                    }
                }
                cards[currIndex].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil

            } else {
                // case B) 2 cards are face up (matching or not matching)
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false //all the cards face down
                }

                // case C) 0 face up cards
                cards[currIndex].isFaceUp = true // the one picked -> face up
                indexOfOneAndOnlyFaceUpCard = currIndex
                // if this card is new, then add it to the dictionary:
                if historyOfCardChoises[cards[currIndex].identifier] == nil {
                    historyOfCardChoises[cards[currIndex].identifier] = 0
                }
            }
        }
    }

    func resetGame() {
        flipCount = 0
        score = 0

        historyOfCardChoises.removeAll()
        indexOfOneAndOnlyFaceUpCard = nil

        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()

       self.theme = themes[Int(arc4random_uniform(UInt32(themes.count)))]
    }
}
