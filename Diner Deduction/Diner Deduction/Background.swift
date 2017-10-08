
import SpriteKit

/**
 Creates an `SKSpriteNode` to use as a background. Sets its texture, size, position, z-position and anchorpoint.
 ### Parameters used on init(): ###
 * `textureName` is the name of the asset to fetch from the "Backgrounds" texture atlas.
 * `frameSize` is the size of the parent scene's frame, to ensure the background covers the whole scene.
 */
class Background {
    /// The background as an `SKSprite`.
    var sprite: SKSpriteNode
    ///
    init(textureName: String, frameSize: CGSize) {
        let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "Backgrounds")
        let bodyTexture = textureAtlas.textureNamed(textureName)
        
        sprite = SKSpriteNode(texture: bodyTexture, size: frameSize)
        sprite.zPosition = 0
        sprite.anchorPoint = CGPoint(x:0, y: 1)
        sprite.position = CGPoint(x: 0, y: frameSize.height)
    }
}
