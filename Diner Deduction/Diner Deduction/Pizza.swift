//
//  Pizza.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 12/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class Pizza : SKSpriteNode, GameSprite {    
    init(positionX: CGFloat, positionY: CGFloat) {
        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: "pizza"), color: UIColor.clear, size: CGSize(width: 250, height: 250))
        self.position = CGPoint(x: positionX, y: positionY)
    }
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

