
import SpriteKit
import SpriteKitEasingSwift

class Ingredient : SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Ingredients")
    var originalPosition:CGPoint = CGPoint(x: 0, y: 0)

    init(name: String, image: String, size: CGSize, positionX: CGFloat, positionY: CGFloat) {

        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: image), color: UIColor.clear, size: size)
        
        self.name = name
        self.size = size
        self.zPosition = 4
        self.position = CGPoint(x: positionX, y: positionY)
        self.originalPosition = CGPoint(x: positionX, y: positionY)
        
        
        let bodyTexture = textureAtlas.textureNamed(image)
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.ingredient.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.collisionBitMask = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(springBackToOriginalPosition), name:Notification.Name("GameFailed"),  object: nil)
    
    }
    
    func springBackToOriginalPosition() {
        self.run(SKEase.move(
            easeFunction: .curveTypeElastic,
            easeType: EaseType.easeTypeOut,
            time: 0.7,
            from: self.position,
            to: self.originalPosition
        ))
    }
    
    func triggerCloudPuff() {
        let cloudPuff = SKEmitterNode(fileNamed: "CloudPuff.sks")
        let addEmitterAction = SKAction.run({ self.addChild(cloudPuff!) })
        let cloudPuffDuration = CGFloat( (cloudPuff?.numParticlesToEmit)!) * (cloudPuff?.particleLifetime)!
        
        //wait for emitter to finish then destroy it for performance reasons
        let wait = SKAction.wait(forDuration: TimeInterval(cloudPuffDuration - 0.4))
        let removeEmitter = SKAction.run({ cloudPuff?.removeFromParent() })
        let sequence = SKAction.sequence([ addEmitterAction, wait, removeEmitter ])
        
        self.run(sequence)
    }
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let positionToMoveTo = CGPoint(x: currentPosition.x - previousPosition.x, y: currentPosition.y - previousPosition.y)
        
        self.position = CGPoint(x: self.position.x + positionToMoveTo.x, y: self.position.y + positionToMoveTo.y)
    }
    
    func onDrop() {
        let bodies = self.physicsBody?.allContactedBodies()
        if (bodies?.isEmpty)! {
            springBackToOriginalPosition()
            //This does fire every time you move an ingredient around
            NotificationCenter.default.post(name:Notification.Name("IngredientRemoved"), object: nil, userInfo: ["ingredient": self.name!])
        }
        else {
            for body : AnyObject in bodies! {
                if body.node??.name == "pizza" {
                    triggerCloudPuff()
                    NotificationCenter.default.post(name:Notification.Name("IngredientAdded"), object: nil, userInfo: ["ingredient": self.name!])
                    break
                }
            }
        }
    }
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
