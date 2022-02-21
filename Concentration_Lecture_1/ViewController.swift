//
//  ViewController.swift
//  Concentration_Lecture_1
//
//  Created by Rona Bompa on 18.02.2022.
//
import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            //flipCard(withEmoji: emojiChoises[cardNumber], on: sender)
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }

    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }

    //var emojiChoises = ["☀️","🌧","⚡️","☀️","🌧","⚡️"]
    var emojiChoises = ["☀️","🌧","⚡️", "🌈", "❄️", "🌪", "⛈" ,"🌬","🌦","🌒"]

    var emoji = [Int:String]()  // special syntax for dictionary

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
        }
//        if chosenEmoji = emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
// same thing as:
        return emoji[card.identifier] ?? "?"
    }

//    func flipCard(withEmoji emoji: String, on button: UIButton){
//        if button.currentTitle == emoji {
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = UIColor.orange
//        } else {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = UIColor.white
//        }
//    }

}

