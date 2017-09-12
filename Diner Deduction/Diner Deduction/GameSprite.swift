//
//  GameSprite.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 10/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    func onTouch()
    func onDrag(touch:UITouch)
    func onDrop()
}
