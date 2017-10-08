
import SpriteKit
/// Null version of `GameSprite`. This is needed so that the `selectedNode` in `GamePlayScene` always conforms to the `GameSprite` protocol. It is an null object for when the player taps something other than an instance of `GameSprite` (such as the background).

class GameSpriteNull : SKSpriteNode, GameSprite {
    ///
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 0, height: 0))
    }
    /// Handle tap behaviour
    func onTouch() {}
    /// Handle drag behaviour
    func onDrag(touch: UITouch) {}
    /// Handle drop behaviour
    func onDrop() {}
    
    /// Satisfy the `NSCoder` required init, as this class inherits from others.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
