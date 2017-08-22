//
//  GameScene.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/08/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "background-game.png")
        background.zPosition = 0
        self.addChild(background)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }

    func createIngredients() {
        let ingredients = [
            (type: "tomato", offsetX: 150),
            (type: "olive", offsetX: 250),
            (type: "mushroom", offsetX: 350),
            (type: "pepperoni", offsetX: 450)
        ];
        
        for (type, offsetX) in ingredients {
            createIngredient(ingredient: type, offsetX: offsetX)
//      	self.addChild(Ingredient(spriteName: type, offsetX: offsetX))

        }
    }
    
    func createIngredient(ingredient: String, offsetX: Int) {
        let thisIngredient = SKSpriteNode(imageNamed: ingredient)
        thisIngredient.size = CGSize(width:50, height:50)
        thisIngredient.position = CGPoint(x: offsetX, y: 150)
        self.addChild(thisIngredient)
    }
    
    func createPizza() {
        let pizza = SKSpriteNode(imageNamed: "pizza")
        pizza.size = CGSize(width:100, height:100)
        pizza.position = CGPoint(x: 300, y: 300)
        self.addChild(pizza)
    }

    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
    
        createBackground()
        createPizza()
      	createIngredients()
    }

    
    // Touch handling
    
    var touchLocation = CGPoint(x: 0, y:0)
    var nrTouches = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.location(in: self)
        nrTouches += touches.count
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nrTouches -= touches.count
    }
    
    //Update function
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
