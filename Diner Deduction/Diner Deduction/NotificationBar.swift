
import SpriteKit
/**
 This notification bar sits at top of the screen and displays text to update the player about the game state.
 ### Parameters used on init(): ###
 * `frameWidth` is the width of the scene's frame, so the bar can position itself accordingly.
 * `frameHeight` is the height of the scene's frame, so the bar can position itself accordingly.
 * `totalIngredients` is the number of ingredients to select for this game (currently this is always 3).
 */
class NotificationBar {
    /// Sprite for the bar.
    var bar: SKSpriteNode
    /// Text label for the bar.
    var message: SKLabelNode
    /// "GameItems" texture atlas.
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    /// Dictionary to hold various messages.
    private let messageDictionary:[String: String]
    /// Sets up a message dictionary with the various messages. Creates a sprite for the bar with a text label. Listens for various game notifications to update the message text.
    init(frameWidth: CGFloat, frameHeight: CGFloat, totalIngredients: Int) {
        
        messageDictionary = [
            "Default": "Quick! Make me a pizza with \(totalIngredients) toppings!",
            "GameWon": "You won!",
            "NotEnoughIngredients": "Not enough toppings! Make a pizza with \(totalIngredients) toppings",
            "TooManyIngredients": "Too many toppings! Make a pizza with \(totalIngredients) toppings"
        ]
        
        let bodyTexture = textureAtlas.textureNamed("notification-bar-bg")
        
        bar = SKSpriteNode(texture: bodyTexture, color: UIColor.gray, size:CGSize(width: frameWidth, height: 40) )
        bar.anchorPoint = CGPoint(x:0, y: 1)
        bar.position = CGPoint(x: 0, y: frameHeight)
        bar.zPosition = 4;
        
        message = SKLabelNode(fontNamed: "Arial")
        message.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        message.zPosition = 5;
        message.text = messageDictionary["Default"]
        message.fontSize = 22
        message.position = CGPoint(x:20, y: frameHeight - 27)
        pulseMessage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("GameWon"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("GameFailed"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("NotEnoughIngredients"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("TooManyIngredients"),  object: nil)
    }
    /// Pulse animation to make the message text more noticable.
    func pulseMessage() {
        let pulse = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.4),
            SKAction.fadeAlpha(to: 1, duration: 0.4),
        ])
        message.run(SKAction.repeat(pulse, count: 3))
    }
    /// Update the label text shown in the notification bar.
    @objc func updateMessage(_ notification: Notification) {
        let newMessage = String(describing: notification.name.rawValue)
        if let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int {
            message.text = "No! I only like \(numberOfItemsCorrect) of those items!"
        }
        else {
            message.text = messageDictionary[newMessage]
        }
        pulseMessage()
    }
    
}


