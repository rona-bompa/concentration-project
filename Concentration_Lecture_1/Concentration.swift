//
//  Concentration.swift
//  Concentration_Lecture_1
//
//  Created by Rona Bompa on 18.02.2022.
//

import Foundation

class Concentration {

    var cards = Array<Card>()   // or [Card]

    var indexOfOneAndONlyFaceUpCard: Int?

    func choseCard(at index: Int) {
        if !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndONlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndONlyFaceUpCard = nil
            } else {
                // either no card or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndONlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairOfCards: Int) {
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            // cards.append(card)  // a copy to card struct
            // cards.append(card)  // matchhing card // another copy to card struct
            // same thihng as:
            cards += [card, card]
        }

        // TODO: Shuffle the cards
    }
}
