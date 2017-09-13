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

    init(name: String, image: String, size: CGSize, positionX: CGFloat, positionY: CGFloat) {

        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: image), color: UIColor.clear, size: size)
        
        self.size = size
        self.position = CGPoint(x: positionX, y: positionY)
        self.originalPosition = CGPoint(x: positionX, y: positionY)
        
        let bodyTexture = textureAtlas.textureNamed(image)
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ingredient.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func addToPizza() {
        print("Ingredient class received onPizza event")
        isOnPizza = true
        self.physicsBody?.categoryBitMask = 0
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
        if (isOnPizza) {
            print("Ingredient is on pizza")
            //do nothing
        }
        else {
            self.run(SKEase.move(
                easeFunction: .curveTypeQuintic,
                easeType: EaseType.easeTypeOut,
                time: 0.5,
                from: self.position,
                to: self.originalPosition
            ))
        }
    }

    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}