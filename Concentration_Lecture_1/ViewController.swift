//
//  ViewController.swift
//  Concentration_Lecture_1
//
//  Created by Rona Bompa on 18.02.2022.
//
import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)

    // Flip Count
    @IBOutlet weak var flipCountLabel: UILabel!
    var flipCount = 0 {
        didSet {

        }
    }

    // Card Buttons -> what happens when you touch
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons Outlet Collection")
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }

    // Emojis
    var emojiChoises = ["🎻","🎹","🎷", "🎺", "🎸", "🪕", "🪘" ,"🎤","🎼","🪗"]
    var emoji = [Int:String]()
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
    }


    var sportsEmojiChoises = ["🏀","⚽️","🥎", "🏐", "🏓", "🎱", "🏉" ,"🏸","🥊","🏹"]
    var foodEmojiChoises = ["🍎","🫐","🍉", "🍇", "🍍", "🥝", "🥥" ,"🍒","🍋","🍊"]
    var vegetablesEmojiChoises = ["🧄","🌶","🍅", "🥒", "🥬", "🥦", "🥕" ,"🫒","🥔","🧅"]
    var fashionEmojiChoises = ["👘","👠","👢", "👔", "👞", "👒", "🪡" ,"🧵","👗","👛"]
    var animalsEmojiChoises = ["🦁","🐰","🐨", "🐔", "🦊", "🐻", "🐒" ,"🐴","🐢","🐬"]


}

