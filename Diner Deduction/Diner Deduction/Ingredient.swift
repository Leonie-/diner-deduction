//
//  Ingredient.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 10/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit
import SpriteKitEasingSwift

class Ingredient : SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Ingredients")
    var originalPosition:CGPoint = CGPoint(x: 0, y: 0)
    var isOnPizza = false
    var ingredientName = ""

    init(name: String, image: String, size: CGSize, positionX: CGFloat, positionY: CGFloat) {

        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: image), color: UIColor.clear, size: size)
        
        self.size = size
        self.position = CGPoint(x: positionX, y: positionY)
        self.originalPosition = CGPoint(x: positionX, y: positionY)
        
        let bodyTexture = textureAtlas.textureNamed(image)
        ingredientName = image
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ingredient.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func addToPizza() {
        isOnPizza = true
        print ("Ingredient is on pizza:", ingredientName)
        NotificationCenter.default.post(name:Notification.Name("IngredientAdded"), object: nil, userInfo: ["ingredient": ingredientName])
        
    }
    
    func removeFromPizza() {
        isOnPizza = false
        print ("Ingredient is removed from pizza:", ingredientName)
        NotificationCenter.default.post(name:Notification.Name("IngredientRemoved"), object: nil, userInfo: ["ingredient": ingredientName])
        
    }
    
    func springBackToOriginalPosition() {
        self.run(SKEase.move(
            easeFunction: .curveTypeQuintic,
            easeType: EaseType.easeTypeOut,
            time: 0.5,
            from: self.position,
            to: self.originalPosition
        ))
    }
    
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let positionToMoveTo = CGPoint(x: currentPosition.x - previousPosition.x, y: currentPosition.y - previousPosition.y)
        
        self.position = CGPoint(x: self.position.x + positionToMoveTo.x, y: self.position.y + positionToMoveTo.y)
        self.zPosition = 1
    }
    
    func onDrop() {
        if (!isOnPizza) {
            springBackToOriginalPosition()
        }
    }

    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
