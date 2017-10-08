
import SpriteKit
import SpriteKitEasingSwift
/**
 This class creates an ingredient sprite with a physics body for collision detection with the `Pizza`. It also handles touch behaviour and animations for the ingredient.
 ### Parameters used on init(): ###
 * `name` is the name of the ingredient.
 * `image` is the name of the ingredient's image.
 * `size` is the size of the ingredient.
 * `positionX` is the x position of the ingredient.
 * `positionY` is the y position of the ingredient.
 */
class Ingredient : SKSpriteNode, GameSprite {
    /// "Ingredients" texture atlas.
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Ingredients")
    /// Sets up a default position for the ingredient (this will be set properly on init).
    var originalPosition:CGPoint = CGPoint(x: 0, y: 0)
    /// Sets up the ingredient sprite with its position and adds a physics body to it. Listens for a "GameFailed" notification to spring an item back to its original position.
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
    /// Animation to make an ingredient spring back to its original position.
    func springBackToOriginalPosition() {
        self.run(SKEase.move(
            easeFunction: .curveTypeElastic,
            easeType: EaseType.easeTypeOut,
            time: 0.7,
            from: self.position,
            to: self.originalPosition
        ))
    }
    /// Triggers a small cloud puff animation underneath the ingredient. Destroys the emitter after a short duration for performance reasons.
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
    
    /// Handles tap behaviour. Not used.
    func onTouch() {}
    /// Handles drag behaviour. Moves the ingredient sprite to its new location.
    func onDrag(touch: UITouch) {
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let positionToMoveTo = CGPoint(x: currentPosition.x - previousPosition.x, y: currentPosition.y - previousPosition.y)
        
        self.position = CGPoint(x: self.position.x + positionToMoveTo.x, y: self.position.y + positionToMoveTo.y)
    }
    /// Handles drop behaviour. Detects collision with the pizza,and either places the item on the pizza with a cloud puff animation, or springs the item back to its original position. Posts notifications about whether an ingredient has been removed or addded to the pizza.
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
    
    /// Satisfy the `NSCoder` required init, as this class inherits from others.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
