
import SpriteKit
/// Protocol for game sprites that need to respond to touch.
protocol GameSprite {
    /// Handle tap behaviour
    func onTouch()
    /// Handle drag behaviour
    func onDrag(touch:UITouch)
    /// Handle drop behaviour
    func onDrop()
}
