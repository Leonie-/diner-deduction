
import SpriteKit
/**
 Used by all the buttons in the game and menus. Sets position, and texture of the button from the "Buttons" texture atlas. Handles tap behaviour.
 ### Parameters used on init(): ###
 * `imageName` is the name of the asset to fetch from the "Buttons" texture atlas.
 * `notificationAction` is the name of the notification to call when the button is pressed.
 * `size` is the size of the button.
 * `position` is where the button is positioned.
 */
class Button: SKSpriteNode, GameSprite {
    /// The button texture atlas.
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "Buttons")
    /// The name of the action will be set after the button is initialised.
    private var action = ""
    /// The button texture atlas.
    init(imageName: String, notificationAction: String, size: CGSize,  position: CGPoint) {
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = 6
        
        self.action = notificationAction
    }
    /// Posts a notification with the name of the `notificationAction` parameter.
    func onTouch() {
        NotificationCenter.default.post(name:Notification.Name(self.action), object: nil)
    }
    /// Adds `onDrag` to conform with the `GameSprite` protocol. Unused.
    func onDrag(touch: UITouch) {}
    /// Adds `onDrop` to conform with the `GameSprite` protocol. Unused.
    func onDrop() {}
    
    /// Satisfy the `NSCoder` required init, as this class inherits from others.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
