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
            (type: "tomato", offsetX: 150 as CGFloat),
            (type: "olive", offsetX: 250 as CGFloat),
            (type: "mushroom", offsetX: 350 as CGFloat),
            (type: "pepperoni", offsetX: 450 as CGFloat)
        ];
        
        for (type, offsetX) in ingredients {
            createIngredient(ingredient: type, offsetX: offsetX)
        }
    }
    
    func createIngredient(ingredient: String, offsetX: CGFloat) {
        let thisIngredient = Sprite(
            name: "ingredient",
            image: ingredient,
            size: CGSize(width:50, height:50),
            positionX: offsetX,
            positionY: 40
        )
        self.addChild(thisIngredient.sprite)
    }
    
    func createPizza() {
        let pizza = Sprite(
            name: "pizza",
            image: "pizza",
            size: CGSize(width: 250, height: 250),
            positionX: self.frame.midX,
            positionY: self.frame.midY
        )
        self.addChild(pizza.sprite)
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
        resetIngredientNode()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		resetIngredientNode()
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
    
    func resetIngredientNode() {
        if selectedNode.name as String? == "ingredient" {
            let originalPosition = selectedNode.userData?.value(forKey: "initialPosition") as! CGPoint
            selectedNode.run(SKEase.move(
                easeFunction: .curveTypeQuintic,
                easeType: EaseType.easeTypeOut,
                time: 0.5,
                from: selectedNode.position,
                to: originalPosition
            ))
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
