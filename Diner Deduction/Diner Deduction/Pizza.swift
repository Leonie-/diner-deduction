
import SpriteKit
/**
 This class creates a pizza sprite with a physics body for collision detection with the various instances of `Ingredient`. It keeps track of what ingredients have been added to it, and listens for various game events.
 ### Parameters used on init(): ###
 * `frame` is the the scene's frame as a `CGRect`.
 * `totalIngredients` is the number of ingredients required for this game (currently this is always 3).
 */
class Pizza : SKSpriteNode, GameSprite {
    /// "GameItems" texture atlas.
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    /// Set of ingredients added to the pizza.
    private var ingredients = Set<String>()
    /// Sets up the pizza sprite and adds a physics body to it. Listens for various game events.
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
    /// Checks the number of ingredients added to the pizza and posts a relevant notification.
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
    /// Adds an ingredient to the list.
    func addIngredient(_ notification: Notification) {
        if let ingredient = notification.userInfo?["ingredient"] as? String {
            ingredients.insert(ingredient)
        }
    }
    /// Removes and ingredient from the list.
    func removeIngredient(_ notification: NSNotification) {
        if let ingredient = notification.userInfo?["ingredient"] as? String {
        	ingredients.remove(ingredient)
        }
    }
    /// Clears all ingredients from the list.
    func removeAllIngredients(_ notification: NSNotification) {
        ingredients.removeAll()
    }
    /// Handle tap behaviour. Currently not used.
    func onTouch() {}
    /// Handle drag behaviour. Currently not used.
    func onDrag(touch: UITouch) {}
    /// Handle drop behaviour. Currently not used.
    func onDrop() {}
    
    /// Satisfy the `NSCoder` required init, as this class inherits from others.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

