
import SpriteKit

class Background {
    var sprite: SKSpriteNode
    
    init(textureName: String, frameSize: CGSize) {
        let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "Backgrounds")
        let bodyTexture = textureAtlas.textureNamed(textureName)
        
        sprite = SKSpriteNode(texture: bodyTexture, size: frameSize)
        sprite.zPosition = 0
        sprite.anchorPoint = CGPoint(x:0, y: 1)
        sprite.position = CGPoint(x: 0, y: frameSize.height)
    }
}
