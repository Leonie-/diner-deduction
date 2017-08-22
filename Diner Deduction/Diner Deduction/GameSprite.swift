//
//  GameSprite.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/08/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas: SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}
