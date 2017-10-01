
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuesses {
    
    public var section: SKSpriteNode
    var previousGuesses: Array<PreviousGuess>!
    
    init() {
        section = SKSpriteNode(color: UIColor.gray, size:CGSize(width: 240, height: 110) )
        section.anchorPoint = CGPoint(x:0, y: 0)
        section.position = CGPoint(x: 0, y: 0)
        section.zPosition = 4;
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePreviousGuesses), name:Notification.Name("GameFailed"),  object: nil)
    }

    @objc func updatePreviousGuesses(_ notification: Notification) {
        let itemsGuessed = notification.userInfo?["itemsGuessed"] as! Set<String>
        let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int
        var xPosition: CGFloat = 10
        
        if previousGuesses?.isEmpty == false {
            xPosition = 100
        }
        
        let pizzaGuess = PreviousGuess(
            itemsGuessed: itemsGuessed,
            numberOfItemsCorrect: numberOfItemsCorrect!,
            xPosition: xPosition
        )
        section.addChild(pizzaGuess.sprite)
        
        if (previousGuesses?.append(pizzaGuess)) == nil {
           previousGuesses = [pizzaGuess]
        }
    }
}



