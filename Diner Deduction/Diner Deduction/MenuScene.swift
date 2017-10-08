import SpriteKit
import GameKit
/**
 This scene appears when game initially loads, or when the `GameViewController` switches to this scene.
 ### Parameters used on init(): ###
 * `size` is the size of the view bounds passed in by the `GameViewController`.
 */
class MenuScene: SKScene, GKGameCenterControllerDelegate {
    ///  Delegate to handle the displaying of game scenes.
    var gameSceneDelegate: GameSceneDelegate?
    /// "MenuScreen" texture atlas.
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"MenuScreen")
    /// Start button sprite.
    var startButton = SKSpriteNode()
    /// Quit button sprite.
    var quitButton = SKSpriteNode()
    /// Creates a background with texture from the "MenuScreen" texture atlas.
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "menu-bg", frameSize: frameSize )
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red:0.60, green:0.50, blue:0.69, alpha:1.0)
    }
    /// Creates a sprite for the Diner Deduction logo.
    func createLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: 390, height: 295)
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY+20 )
        logo.zPosition = 1
        self.addChild(logo)
    }
    /// Creates a start `Button` and adds it to the scene.
    func createStartButton() {
        startButton = Button(
            imageName: "blue-btn",
            notificationAction: "StartButtonPressed",
            size: CGSize(width: 190, height: 50),
            position: CGPoint(x: self.frame.midX, y: self.frame.midY-120 )
        )
        startButton.name = "start-button"
        self.addChild(startButton)
    }
    /// Adds text to the start `Button` sprite.
    func addTextToSprite(sprite: SKSpriteNode, text: String, name: String, addPulse: Bool) {
        let textNode = SKLabelNode(fontNamed: "Arial-BoldMT")
        textNode.text = text
        textNode.name = name
        textNode.verticalAlignmentMode = .center
        textNode.position = CGPoint(x: 0, y: -3)
        textNode.zPosition = 5
        textNode.fontSize = 30
        
        if (addPulse) {
            let pulse = SKAction.sequence([
                SKAction.fadeAlpha(to: 0.6, duration: 0.6),
                SKAction.fadeAlpha(to: 1, duration: 0.6),
            ])
            textNode.run(SKAction.repeatForever(pulse))
        }
        sprite.addChild(textNode)
    }
    ///
    override init(size: CGSize) {
        super.init(size: size)
    }
    /// Sets up the scene with various sprites
    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
        
        createBackground()
        createLogo()
        createStartButton()
        addTextToSprite(sprite: startButton, text: "Start game", name: "start-button", addPulse: true)
    }
    /// Detect button taps switch to either menu or game scenes using the `GameSceneDelegate`.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if touchedNode.name == "start-button" {
                self.gameSceneDelegate?.gamePlayScene()
            }
        }
    }
    /// Dismiss the scene when the user has finished interacting with it.
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    /// Satisfy the `NSCoder` required init, as this class inherits from others.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

