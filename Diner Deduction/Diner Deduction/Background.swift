
import SpriteKit

class Background {
    
    var sprite: SKSpriteNode
    
    init(textureName:String, frameWidth: CGFloat, frameHeight: CGFloat) {
        let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "Backgrounds")
        let bodyTexture = textureAtlas.textureNamed(textureName)
        
        sprite = SKSpriteNode(texture: bodyTexture, size:CGSize(width: frameWidth, height: frameHeight) )
        sprite.zPosition = 1
        sprite.anchorPoint = CGPoint(x:0, y: 1)
        sprite.position = CGPoint(x: 0, y: frameHeight)
    }
}
