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
    private var ingredients = Set<String>()

    init(positionX: CGFloat, positionY: CGFloat) {
        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: "pizza"), color: UIColor.clear, size: CGSize(width: 210, height: 210))
        self.position = CGPoint(x: positionX, y: positionY)
        self.name = "pizza"
        
        let bodyTexture = textureAtlas.textureNamed("pizza")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: CGSize(width: 105, height: 105))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.pizza.rawValue
        self.physicsBody?.collisionBitMask = 0
        
		NotificationCenter.default.addObserver(self, selector: #selector(submitPizza), name:Notification.Name("SubmitButtonPressed"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addIngredient), name:Notification.Name("IngredientAdded"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeIngredient), name:Notification.Name("IngredientRemoved"),  object: nil)
    }
    
    func submitPizza() {
        if (ingredients.count < 3) {
            print("Not enough ingredients!")
        }
        else if (ingredients.count > 3) {
            print("Too many ingredients!")
        }
        else {
        	NotificationCenter.default.post(name:Notification.Name("PizzaSubmitted"), object: nil, userInfo: ["currentIngredients": ingredients])
        }
    }
    
    func addIngredient(_ notification: Notification) {
        if let ingredient = notification.userInfo?["ingredient"] as? String {
            ingredients.insert(ingredient)
            print("ingredient added", ingredients)
        }
    }
    
    func removeIngredient(_ notification: NSNotification) {
        if let ingredient = notification.userInfo?["ingredient"] as? String {
        	ingredients.remove(ingredient)
            print("ingredient removed", ingredients)
        }
    }
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

