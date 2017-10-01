
import SpriteKit
import SpriteKitEasingSwift

class PreviousGuess: SKSpriteNode {
    private var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    private var ingredientsTextureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Ingredients")

    private var ingredientPositions: [Int: CGPoint] = [
        1: CGPoint(x: 9, y: 19),
        2: CGPoint(x: 25, y: 40),
        3: CGPoint(x: 35, y: 13)
    ]
    
    private func addLabel(numberOfItemsCorrect: Int) {
        let label = SKLabelNode(fontNamed: "Arial")
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.zPosition = 7
        label.text = "\(numberOfItemsCorrect) right"
        label.fontSize = 18
        label.position = CGPoint(x:13, y: 80)
        self.addChild(label)
    }
    
    private func addPizzaSprite(itemsGuessed: Set<String>, numberOfItemsCorrect: Int) {
        let pizza = SKSpriteNode(texture: textureAtlas.textureNamed("pizza"), color: UIColor.gray, size:CGSize(width: 70, height: 70) )
        pizza.anchorPoint = CGPoint(x:0, y: 0)
        pizza.position = CGPoint(x: 5, y: 5)
        pizza.zPosition = 6
        
        addIngredientsToPizzaSprite(pizza: pizza, itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect)
        self.addChild(pizza)
    }
    
    private func addIngredientsToPizzaSprite(pizza: SKSpriteNode, itemsGuessed: Set<String>, numberOfItemsCorrect: Int) {
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
    
    private func slideUp(xPosition: CGFloat, spriteOffScreenPosition: CGPoint) {
        self.run(SKEase.move(
            easeFunction: .curveTypeQuintic,
            easeType: EaseType.easeTypeOut,
            time: 0.8,
            from: spriteOffScreenPosition,
            to: CGPoint(x: xPosition, y: 0)
        ))
    }
    
    func moveAlong() {
        let positionToMoveTo = CGPoint(x: self.position.x-85, y: 0)
        self.run(SKEase.move(
            easeFunction: .curveTypeQuintic,
            easeType: EaseType.easeTypeOut,
            time: 0.8,
            from: self.position,
            to: positionToMoveTo
        ))
    }

    init(itemsGuessed: Set<String>, numberOfItemsCorrect: Int, xPosition: CGFloat) {
        let size = CGSize(width: 80, height: 100)
        let spriteOffScreenPosition = CGPoint(x: xPosition, y: -300)
        
        super.init(texture: textureAtlas.textureNamed("guess-box"), color: UIColor.clear, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody!.isDynamic = false
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = 0
        self.physicsBody!.collisionBitMask = 0
        self.anchorPoint = CGPoint(x:0, y: 0)
        self.position = spriteOffScreenPosition
        self.zPosition = 5
        
        addLabel(numberOfItemsCorrect: numberOfItemsCorrect)
        addPizzaSprite(itemsGuessed: itemsGuessed, numberOfItemsCorrect: numberOfItemsCorrect)
        slideUp(xPosition: xPosition, spriteOffScreenPosition: spriteOffScreenPosition)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}



