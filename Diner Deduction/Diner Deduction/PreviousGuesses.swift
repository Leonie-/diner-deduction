
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
    
    func slideUpTryBox() {
        
    }
    
    func createPizzaTry(itemsGuessed: Set<String>, numberOfItemsCorrect: Int) {
        
        let tryBoxOffScreenPosition = CGPoint(x: 20, y: -300)
        let tryBox = SKSpriteNode(color: UIColor.blue, size:CGSize(width: 90, height: 110) )
        tryBox.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 100))
        tryBox.physicsBody!.isDynamic = false
        tryBox.physicsBody!.affectedByGravity = false
        tryBox.physicsBody!.categoryBitMask = 0
        tryBox.physicsBody!.collisionBitMask = 0
        tryBox.anchorPoint = CGPoint(x:0, y: 0)
        tryBox.position = tryBoxOffScreenPosition
        tryBox.zPosition = 5

        let pizza = SKSpriteNode(texture: textureAtlas.textureNamed("pizza"), color: UIColor.gray, size:CGSize(width: 70, height: 70) )
        pizza.anchorPoint = CGPoint(x:0, y: 0)
        pizza.position = CGPoint(x: 10, y: 10)
        pizza.zPosition = 6;
    
        tryBox.addChild(pizza)
        
        addIngredientsToPizzaTry(pizza: pizza, itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect)
        
        let label = SKLabelNode(fontNamed: "Arial")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.zPosition = 7;
        label.text = "\(numberOfItemsCorrect) right"
        label.fontSize = 18
        label.position = CGPoint(x:20, y: 90)
        
        tryBox.addChild(label)
        
        section.addChild(tryBox)
        
        tryBox.run(SKEase.move(
            easeFunction: .curveTypeQuintic,
            easeType: EaseType.easeTypeOut,
            time: 0.8,
            from: tryBoxOffScreenPosition,
            to: CGPoint(x: 10, y: 0)
        ))
        
    }

    
    @objc func updatePreviousTries(_ notification: Notification) {
        let itemsGuessed = notification.userInfo?["itemsGuessed"] as? Set<String>
        let numberOfItemsCorrect = notification.userInfo?["numberOfItemsCorrect"] as? Int
        
        previousTries += 1
        
        if previousTries > 1 {
            createPizzaTry(itemsGuessed: itemsGuessed!, numberOfItemsCorrect: numberOfItemsCorrect!)
        }
        else if previousTries > 0 {
            createPizzaTry(itemsGuessed: itemsGuessed!, numberOfItemsCorrect: numberOfItemsCorrect!)
        }
        
    }
}



