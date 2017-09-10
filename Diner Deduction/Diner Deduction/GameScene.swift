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
    
    var selectedNode = SKSpriteNode()
    
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
        }
    }
    
    func createIngredient(ingredient: String, offsetX: Int) {
        let thisIngredient = SKSpriteNode(imageNamed: ingredient)
        thisIngredient.size = CGSize(width:50, height:50)
        thisIngredient.position = CGPoint(x: offsetX, y: 40)
        thisIngredient.name = "ingredient"
        self.addChild(thisIngredient)
    }
    
    func createPizza() {
		let pizza = SKSpriteNode(imageNamed: "pizza")
        pizza.size = CGSize(width: 250, height: 250)
        pizza.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        
        selectNodeForTouch(positionInScene)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let positionToMoveTo = CGPoint(x: currentPosition.x - previousPosition.x, y: currentPosition.y - previousPosition.y)
        
        moveIngredientNode(positionToMoveTo)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
        
    }
    
    func selectNodeForTouch(_ touchLocation : CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode = touchedNode as! SKSpriteNode
            }
        }
    }
    
    func moveIngredientNode(_ positionToMoveTo : CGPoint) {
        let position = selectedNode.position
        
        if selectedNode.name as String? == "ingredient" {
            selectedNode.position = CGPoint(x: position.x + positionToMoveTo.x, y: position.y + positionToMoveTo.y)
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
