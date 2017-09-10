//
//  GameSpriteNull.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 10/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//


import SpriteKit
import SpriteKitEasingSwift

class GameSpriteNull : SKSpriteNode, GameSprite {
    
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "Ingredients")
    
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 0, height: 0))
    }
    
    func onTouch() {}
    
    func onDrag(touch: UITouch) {}
    
    func onDrop() {}
    
    
    // Satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
