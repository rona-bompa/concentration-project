//
//  ViewController.swift
//  Concentration_Lecture_1
//
//  Created by Rona Bompa on 18.02.2022.
//
import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    lazy var emojiChoises = game.theme.emojis
    var emoji = [Int:String]()

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    override func viewDidLoad() {
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = game.theme.cardBackgroundColor
        }
    }

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
                button.backgroundColor = card.isMatched ? UIColor.clear : game.theme.cardBackgroundColor
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    // Emojis
        func emoji(for card: Card) -> String {
            if emoji[card.identifier] == nil, emojiChoises.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
                emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
            }
            return emoji[card.identifier] ?? "?"
        }

        @IBAction func newGame(_ sender: UIButton) {
            game.resetGame() // poate e async
            emojiChoises.removeAll()
            emojiChoises = game.theme.emojis
            emoji.removeAll() // resetez dictionaru
            // reset the buttons
            for index in cardButtons.indices {
                let button = cardButtons[index]
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = game.theme.cardBackgroundColor
            }
            updateViewFromModel()
        }
}

