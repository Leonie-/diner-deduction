
import SpriteKit

class SubmitButton : SKSpriteNode, GameSprite {

    init(positionX: CGFloat, positionY: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "submit-button"), color: UIColor.clear, size: CGSize(width: 142, height: 38))
        self.position = CGPoint(x: positionX, y: positionY)
        self.zPosition = 6
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideSubmitButton), name:Notification.Name("GameWon"),  object: nil)
    }
    
    func hideSubmitButton() {

    }
    
    func onTouch() {
        NotificationCenter.default.post(name:Notification.Name("SubmitButtonPressed"), object: nil)
    }
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
