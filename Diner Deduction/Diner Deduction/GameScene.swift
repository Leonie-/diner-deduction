//
//  GameScene.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/08/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit
import GameplayKit
import SpriteKitEasingSwift

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var selectedNode:GameSprite = GameSpriteNull()
    static var customer:Customer? = nil
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "background-game.png")
        background.zPosition = 0
        self.addChild(background)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    
    func createPizza() {
        let pizza = Pizza(
            positionX: self.frame.midX,
            positionY: self.frame.midY
        )
        self.addChild(pizza)
    }

    func createIngredients(ingredients: Array<(String,CGFloat)>) {
        for (type, offsetX) in ingredients {
            createIngredient(ingredient: type, offsetX: offsetX)
        }
    }
    
    func createIngredient(ingredient: String, offsetX: CGFloat) {
        let ingredient = Ingredient(
            name: ingredient,
            image: ingredient,
            size: CGSize(width:50, height:50),
            positionX: offsetX,
            positionY: 40
        )
        self.addChild(ingredient)
    }
    
    func createSubmitButton() {
        let submitButton = SubmitButton(
            positionX: self.frame.width - 100,
            positionY: 40
        )
        self.addChild(submitButton)
    }

    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
        
        let ingredients = [
            (type: "tomato", offsetX: 150 as CGFloat),
            (type: "olive", offsetX: 250 as CGFloat),
            (type: "mushroom", offsetX: 350 as CGFloat),
            (type: "pepperoni", offsetX: 450 as CGFloat)
        ];

        GameScene.customer = Customer(ingredients: ingredients, totalIngredients: 3, arrayShuffler: ArrayShuffler())
        createBackground()
        createPizza()
        createIngredients(ingredients: ingredients)
        createSubmitButton()
        
        //Handle contact in the scene
        self.physicsWorld.contactDelegate = self
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody
        let secondBody:SKPhysicsBody
        let ingredientMask = PhysicsCategory.ingredient.rawValue
        let pizzaMask = PhysicsCategory.pizza.rawValue

        if (contact.bodyA.categoryBitMask & ingredientMask) > 0 {
//            print("Ingredient is body A")
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
//            print("Ingredient is body B")
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        

        if (secondBody.categoryBitMask == pizzaMask) {
            if let ingredient = firstBody.node as? Ingredient {
            	NotificationCenter.default.post(name:Notification.Name("IngredientAdded"), object: nil, userInfo: ["ingredient": ingredient.name!])
//            if let pizza = secondBody.node as? Pizza {
//                pizza.addIngredient()
//            }
//            if let ingredient = firstBody.node as? Ingredient {
//                ingredient.addToPizza()
//            }
            }
        }

    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody
        let secondBody:SKPhysicsBody
        let ingredientMask = PhysicsCategory.ingredient.rawValue
        let pizzaMask = PhysicsCategory.pizza.rawValue
        
        if (contact.bodyA.categoryBitMask & ingredientMask) > 0 {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if (secondBody.categoryBitMask == pizzaMask) {
            let overlap = (secondBody.node?.contains((firstBody.node?.position)!))!
            if let ingredient = firstBody.node as? Ingredient {
                if (!overlap) {
                    NotificationCenter.default.post(name:Notification.Name("IngredientRemoved"), object: nil, userInfo: ["ingredient": ingredient.name!])
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
    		let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode is GameSprite {
                selectedNode = touchedNode as! GameSprite
                selectedNode.onTouch()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            selectedNode.onDrag(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode.onDrop()
        selectedNode = GameSpriteNull()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode.onDrop()
        selectedNode = GameSpriteNull()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

enum PhysicsCategory:UInt32 {
    case ingredient = 1
    case pizza = 2
}
