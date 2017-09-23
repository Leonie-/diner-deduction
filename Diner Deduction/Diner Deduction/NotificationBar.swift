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
    
    init() {
    
        self.bar = SKShapeNode()
            
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotification), name:Notification.Name("GameWon"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotification), name:Notification.Name("GameFailed"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotification), name:Notification.Name("NotEnoughIngredients"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotification), name:Notification.Name("TooManyIngredients"),  object: nil)
    }
    
    @objc func updateNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            print(message)
        }
    }
    
}


