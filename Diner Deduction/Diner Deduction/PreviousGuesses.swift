
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuesses {
    
    var section: SKSpriteNode
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
        
        section = SKSpriteNode(color: UIColor.gray, size:CGSize(width: 240, height: 110) )
        section.anchorPoint = CGPoint(x:0, y: 0)
        section.position = CGPoint(x: 0, y: 0)
        section.zPosition = 4;
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePreviousTries), name:Notification.Name("GameFailed"),  object: nil)
    }
    
    func addIngredientsToPizzaTry(pizza: SKSpriteNode, itemsGuessed: Set<String>, numberOfItemsCorrect: Int) {
        
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
    
    func createPizzaTry(position: CGPoint, itemsGuessed: Set<String>, numberOfItemsCorrect: Int) {
        let pizza = SKSpriteNode(texture: textureAtlas.textureNamed("pizza"), color: UIColor.gray, size:CGSize(width: 70, height: 70) )
        pizza.anchorPoint = CGPoint(x:0, y: 0)
        pizza.position = position
        pizza.zPosition = 6;
    
        section.addChild(pizza)
        
        addIngredientsToPizzaTry(pizza: pizza, itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect)
        
        let label = SKLabelNode(fontNamed: "Arial")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.zPosition = 5;
        label.text = "\(numberOfItemsCorrect) right"
        label.fontSize = 18
        label.position = CGPoint(x:10, y: 85)
        
        section.addChild(label)
        
    }
    
    @objc func updatePreviousTries(_ notification: Notification) {
        let itemsGuessed = notification.userInfo?["itemsGuessed"] as? Set<String>
        let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int
        
        previousTries += 1
        
        if previousTries > 1 {
            createPizzaTry(position: pizzaTryPositions[2]!, itemsGuessed: itemsGuessed!, numberOfItemsCorrect: numberOfItemsCorrect!)
        }
        else if previousTries > 0 {
            createPizzaTry(position: pizzaTryPositions[1]!, itemsGuessed: itemsGuessed!, numberOfItemsCorrect: numberOfItemsCorrect!)
        }
        
    }
}



