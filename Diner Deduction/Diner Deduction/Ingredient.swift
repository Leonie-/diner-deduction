//
//  Ingredient.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 10/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit
import SpriteKitEasingSwift

class Ingredient : SKSpriteNode, GameSprite {
    var originalPosition:CGPoint = CGPoint(x: 0, y: 0)

    init(name: String, image: String, size: CGSize, positionX: CGFloat, positionY: CGFloat) {
        
        self.originalPosition = CGPoint(x: positionX, y: positionY)
        
        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: SKTexture(imageNamed: image), color: UIColor.clear, size: size)
        
        self.size = size
        self.position = CGPoint(x: positionX, y: positionY)
    }
    
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let positionToMoveTo = CGPoint(x: currentPosition.x - previousPosition.x, y: currentPosition.y - previousPosition.y)
        
        self.position = CGPoint(x: self.position.x + positionToMoveTo.x, y: self.position.y + positionToMoveTo.y)
        self.zPosition = 1
    }
    
    func onDrop() {
        self.run(SKEase.move(
            easeFunction: .curveTypeQuintic,
            easeType: EaseType.easeTypeOut,
            time: 0.5,
            from: self.position,
            to: self.originalPosition
        ))
    }

    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
