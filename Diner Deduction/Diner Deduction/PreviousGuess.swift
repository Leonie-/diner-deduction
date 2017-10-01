
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuess {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    var ingredientsTextureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Ingredients")
    var sprite:SKSpriteNode
    
    var ingredientPositions: [Int: CGPoint] = [
        1: CGPoint(x: 9, y: 19),
        2: CGPoint(x: 25, y: 40),
        3: CGPoint(x: 35, y: 13)
    ]
    
    init(itemsGuessed: Set<String>, numberOfItemsCorrect: Int, xPosition: CGFloat) {
        
        let spriteOffScreenPosition = CGPoint(x: xPosition, y: -300)
        sprite = SKSpriteNode(color: UIColor.blue, size:CGSize(width: 90, height: 110) )
        sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 100))
        sprite.physicsBody!.isDynamic = false
        sprite.physicsBody!.affectedByGravity = false
        sprite.physicsBody!.categoryBitMask = 0
        sprite.physicsBody!.collisionBitMask = 0
        sprite.anchorPoint = CGPoint(x:0, y: 0)
        sprite.position = spriteOffScreenPosition
        sprite.zPosition = 5
        
        let pizza = SKSpriteNode(texture: textureAtlas.textureNamed("pizza"), color: UIColor.gray, size:CGSize(width: 70, height: 70) )
        pizza.anchorPoint = CGPoint(x:0, y: 0)
        pizza.position = CGPoint(x: xPosition, y: 10)
        pizza.zPosition = 6;
        
        sprite.addChild(pizza)
        
        addIngredientsToPizzaTry(pizza: pizza, itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect)
        
        let label = SKLabelNode(fontNamed: "Arial")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.zPosition = 7;
        label.text = "\(numberOfItemsCorrect) right"
        label.fontSize = 18
        label.position = CGPoint(x:20, y: 90)
        
        sprite.addChild(label)
        
//        section.addChild(sprite)
        
        sprite.run(SKEase.move(
            easeFunction: .curveTypeQuintic,
            easeType: EaseType.easeTypeOut,
            time: 0.8,
            from: spriteOffScreenPosition,
            to: CGPoint(x: 10, y: 0)
        ))

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
    
    func slideUpguessBox() {
        
    }

}



