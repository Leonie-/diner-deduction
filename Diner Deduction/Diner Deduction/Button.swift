
import SpriteKit

class Button: SKSpriteNode, GameSprite {
    
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "Buttons")
    private var action = ""
    
    init(imageName: String, notificationAction: String, size: CGSize,  position: CGPoint) {
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = 6
        
        self.action = notificationAction
    }
    
    func onTouch() {
        print("Button Touched")
        NotificationCenter.default.post(name:Notification.Name(self.action), object: nil)
    }
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
