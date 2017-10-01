
import SpriteKit

class GameSpriteNull : SKSpriteNode, GameSprite {
    
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 0, height: 0))
    }
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
