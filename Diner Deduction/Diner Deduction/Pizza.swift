//
//  Pizza.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 12/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class Pizza : SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")

    init(positionX: CGFloat, positionY: CGFloat) {
        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: "pizza"), color: UIColor.clear, size: CGSize(width: 250, height: 250))
        self.position = CGPoint(x: positionX, y: positionY)
        
        let bodyTexture = textureAtlas.textureNamed("pizza")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.collisionBitMask = 0

    }
    
    func addIngredient() {
        print("Ingredient added to Pizza class")
    }
    
    func removeIngredient() {
        print("Ingredient removed from Pizza class")
    }

    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

