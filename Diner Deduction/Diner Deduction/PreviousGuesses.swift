
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuesses {
    
    var tab: SKSpriteNode
    var label: SKLabelNode
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    
    init(frameWidth: CGFloat, frameHeight: CGFloat) {
        let bodyTexture = textureAtlas.textureNamed("notification-bar-bg")
        
        tab = SKSpriteNode(texture: bodyTexture, color: UIColor.gray, size:CGSize(width: 150, height: 70) )
        tab.anchorPoint = CGPoint(x:0, y: 0)
        tab.position = CGPoint(x: 0, y: 0)
        tab.zPosition = 4;
        
        label = SKLabelNode(fontNamed: "Arial")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.zPosition = 5;
        label.text = "Previous tries:"
        label.fontSize = 17
        label.position = CGPoint(x:20, y: 50)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePreviousTries), name:Notification.Name("GameFailed"),  object: nil)
    }
    
    @objc func updatePreviousTries(_ notification: Notification) {
//        let newMessage = String(describing: notification.name.rawValue)
//        if let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int {
//            message.text = "No! I only like \(numberOfItemsCorrect) of those items!"
//        }
//        else {
//            message.text = messageDictionary[newMessage]
//        }
//        message.run(SKEase.move(
//            easeFunction: .curveTypeBounce,
//            easeType: EaseType.easeTypeIn,
//            time: 0.2,
//            from: messagePositionLower,
//            to: message.position
//        ))
    }
    
}



