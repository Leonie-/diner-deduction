
import SpriteKit

class Pizza : SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    private var ingredients = Set<String>()

    init(frame: CGRect, totalIngredients:Int) {
        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: "pizza"), color: UIColor.clear, size: CGSize(width: 215, height: 215))
        self.position = CGPoint(x: frame.midX, y: frame.midY+20)
        self.zPosition = 2
        self.name = "pizza"
        
        let bodyTexture = textureAtlas.textureNamed("pizza")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: CGSize(width: 110, height: 110))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.collisionBitMask = 0
        
		NotificationCenter.default.addObserver(self, selector: #selector(submitPizza), name:Notification.Name("SubmitButtonPressed"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addIngredient), name:Notification.Name("IngredientAdded"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeIngredient), name:Notification.Name("IngredientRemoved"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllIngredients), name:Notification.Name("GameFailed"),  object: nil)
    }
    
    func submitPizza() {
        if (ingredients.count < 3) {
            NotificationCenter.default.post(name:Notification.Name("NotEnoughIngredients"), object: nil)
        }
        else if (ingredients.count > 3) {
            NotificationCenter.default.post(name:Notification.Name("TooManyIngredients"), object: nil)
        }
        else {
        	NotificationCenter.default.post(name:Notification.Name("PizzaSubmitted"), object: nil, userInfo: ["currentIngredients": ingredients])
        }
    }
    
    func addIngredient(_ notification: Notification) {
        if let ingredient = notification.userInfo?["ingredient"] as? String {
            ingredients.insert(ingredient)
        }
    }
    
    func removeIngredient(_ notification: NSNotification) {
        if let ingredient = notification.userInfo?["ingredient"] as? String {
        	ingredients.remove(ingredient)
        }
    }
    
    func removeAllIngredients(_ notification: NSNotification) {
        ingredients.removeAll()
    }
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

