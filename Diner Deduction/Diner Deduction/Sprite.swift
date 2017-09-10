//
//  Sprite
//  Diner Deduction
//
//  Created by Leonie Kenyon on 10/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class Sprite {
    
    var sprite: SKSpriteNode
    
    init(name:String, image:String, size:CGSize, positionX: CGFloat, positionY: CGFloat) {
        
        sprite = SKSpriteNode(imageNamed: image)
        sprite.name = name
        sprite.size = size
        sprite.position = CGPoint(x: positionX, y: positionY)
        
        let initialPosition = NSValue.init(cgPoint: sprite.position)
        
        sprite.userData = ["initialPosition": initialPosition]
    }
}
