
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuesses {
    
    public var section: SKSpriteNode
    var previousGuesses: Array<PreviousGuess> = []
    
    init() {
        section = SKSpriteNode(color: UIColor.clear, size:CGSize(width: 200, height: 110) )
        section.anchorPoint = CGPoint(x:0, y: 0)
        section.position = CGPoint(x: 0, y: 0)
        section.zPosition = 4;
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePreviousGuesses), name:Notification.Name("GameFailed"),  object: nil)
    }
    
    func moveExistingGuessesAlong() {
        if (previousGuesses.count) > 2 {
            for guessBox in previousGuesses {
                guessBox.moveAlong()
            }
            //removing offscreen sprites for performance
            previousGuesses.first?.removeFromParent()
            previousGuesses.remove(at: 0)
        }
    }
    
    func displayNewGuess(itemsGuessed: Set<String>, numberOfItemsCorrect: Int) {
        let xPosition: CGFloat = (previousGuesses.isEmpty) ? 5 : (previousGuesses.count == 1) ? 110 : 215
        let pizzaGuess = PreviousGuess(
            itemsGuessed: itemsGuessed,
            numberOfItemsCorrect: numberOfItemsCorrect,
            xPosition: xPosition
        )
        
        section.addChild(pizzaGuess)
        previousGuesses.append(pizzaGuess)
    }

    @objc func updatePreviousGuesses(_ notification: Notification) {
        let itemsGuessed = notification.userInfo?["itemsGuessed"] as! Set<String>
        let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int
        
        moveExistingGuessesAlong()
        displayNewGuess(itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect!)
    }
}



