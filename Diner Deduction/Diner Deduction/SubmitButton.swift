//
//  SubmitButton.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class SubmitButton : SKSpriteNode, GameSprite {

    init(positionX: CGFloat, positionY: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "submit-button"), color: UIColor.clear, size: CGSize(width: 142, height: 38))
        self.position = CGPoint(x: positionX, y: positionY)
    }
    
    func onTouch() {
    	print("Submit pizza")
    }
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
