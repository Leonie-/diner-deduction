
import SpriteKit
import SpriteKitEasingSwift
/**
 Listens for the "GameFailed" notification and adds a `PreviousGuess` to an array of previous guesses. Slides them across the screen when new ones are added, and destroys the oldest when there are more than 3 on the screen at a time.
 */
class PreviousGuesses {
    /// Sprite for the previous guess section.
    public var section: SKSpriteNode
    /// Array of `PreviousGuess` items.
    var previousGuesses: Array<PreviousGuess> = []
    /// Keeps track of the total number of guesses.
    var total: Int = 1;
    /// Creates a sprite for the previous guess section. Adds a listener for the "GameFailed" state.
    init() {
        section = SKSpriteNode(color: UIColor.clear, size:CGSize(width: 200, height: 110) )
        section.anchorPoint = CGPoint(x:0, y: 0)
        section.position = CGPoint(x: 0, y: 0)
        section.zPosition = 4;
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePreviousGuesses), name:Notification.Name("GameFailed"),  object: nil)
    }
    /// Animation to slide the previous guess boxes along and destroy the ones offscreen.
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
    /// Creates a new `PreviousGuess` and adds it to the array.
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
    /// Respond to the "GameFailed" notification by displaying a new previous guess and displaying how many ingredients were correct.
    @objc func updatePreviousGuesses(_ notification: Notification) {
        let itemsGuessed = notification.userInfo?["itemsGuessed"] as! Set<String>
        let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int
        
        moveExistingGuessesAlong()
        displayNewGuess(itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect!)
        total += 1
    }
}



