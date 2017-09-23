
import SpriteKit

protocol GameSprite {
    func onTouch()
    func onDrag(touch:UITouch)
    func onDrop()
}
