//
//  Pizza.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 12/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit
import SpriteKitEasingSwift

class Pizza : SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    var originalPosition:CGPoint = CGPoint(x: 0, y: 0)
    
    init(name: String, image: String, size: CGSize, positionX: CGFloat, positionY: CGFloat) {
        let imageName = SKTexture(imageNamed: image)
        
        self.originalPosition = CGPoint(x: positionX, y: positionY)
        
        // Call the init function on the base class (SKSpriteNode)
        super.init(texture: imageName, color: UIColor.clear, size: size)
        
        self.size = size
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

