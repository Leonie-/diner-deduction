
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuesses {
    
    var tab: SKSpriteNode
    var label: SKLabelNode
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    var ingredientsTextureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Ingredients")

    var previousTries = 0;
    
    var pizzaTryPositions: [Int: CGPoint] = [
        1: CGPoint(x: 120, y: 10),
        2: CGPoint(x: 10, y: 10)
    ]
    var ingredientPositions: [Int: CGPoint] = [
        1: CGPoint(x: 9, y: 19),
        2: CGPoint(x: 25, y: 40),
        3: CGPoint(x: 35, y: 13)
    ]
    
    init(frameWidth: CGFloat, frameHeight: CGFloat) {
        let bodyTexture = textureAtlas.textureNamed("notification-bar-bg")
        
        tab = SKSpriteNode(texture: bodyTexture, color: UIColor.gray, size:CGSize(width: 240, height: 110) )
        tab.anchorPoint = CGPoint(x:0, y: 0)
        tab.position = CGPoint(x: 0, y: 0)
        tab.zPosition = 4;
        
        label = SKLabelNode(fontNamed: "Arial")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.zPosition = 5;
        label.text = "Previous tries:"
        label.fontSize = 18
        label.position = CGPoint(x:10, y: 85)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePreviousTries), name:Notification.Name("GameFailed"),  object: nil)
    }
    
    func createPizzaTry(position: CGPoint, itemsGuessed: Set<String>) {
        let pizza = SKSpriteNode(texture: textureAtlas.textureNamed("pizza"), color: UIColor.gray, size:CGSize(width: 70, height: 70) )
        pizza.anchorPoint = CGPoint(x:0, y: 0)
        pizza.position = position
        pizza.zPosition = 6;
    
        tab.addChild(pizza)
        
        var ingredientNumber = 1
        
        for ingredient in itemsGuessed as Set<String> {
            let ingredientTexture = ingredientsTextureAtlas.textureNamed(ingredient)
            let ingredientSprite = SKSpriteNode(texture: ingredientTexture, color: UIColor.gray, size:CGSize(width: 20, height: 20) )
            ingredientSprite.anchorPoint = CGPoint(x:0, y: 0)
            ingredientSprite.position = ingredientPositions[ingredientNumber]!
            ingredientSprite.zPosition = 7
            pizza.addChild(ingredientSprite)
            ingredientNumber += 1
        }
        
    }
    
    @objc func updatePreviousTries(_ notification: Notification) {
        let itemsGuessed = notification.userInfo?["itemsGuessed"] as? Set<String>
        
        previousTries += 1
        
        if previousTries > 1 {
            createPizzaTry(position: pizzaTryPositions[2]!, itemsGuessed: itemsGuessed!)
        }
        else if previousTries > 0 {
            createPizzaTry(position: pizzaTryPositions[1]!, itemsGuessed: itemsGuessed!)
        }
        
    }
}



