//
//  NotificationBar.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 23/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class NotificationBar {
    
    var bar: SKShapeNode
    var message: SKLabelNode
    private let messageDictionary = [
        "GameWon": "You won!",
        "GameFailed": "Nope, try again",
        "NotEnoughIngredients": "Not enough toppings!",
        "TooManyIngredients": "Too many toppings!"
    ]
    
    init(frame: CGRect, totalIngredients: Int) {
    
        self.bar = SKShapeNode()
        
        message = SKLabelNode(fontNamed: "Arial")
        message.text = "Quick! Make me a pizza with \(totalIngredients) toppings!"
        message.fontSize = 20
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("GameWon"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("GameFailed"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("NotEnoughIngredients"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage), name:Notification.Name("TooManyIngredients"),  object: nil)
    }
    
   @objc func updateMessage(_ notification: Notification) {
        let newMessage = String(describing: notification.name.rawValue)
        message.text = messageDictionary[newMessage]
        print(messageDictionary[newMessage])
    }
    
}


