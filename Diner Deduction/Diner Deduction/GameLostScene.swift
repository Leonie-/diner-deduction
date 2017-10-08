import GameKit
import SpriteKit
import SpriteKitEasingSwift

/**
 This scene appears when the timer has run out and the player has not guessed the correct combination of ingredients. It has a panel saying, "Oh no! You ran out of time", and buttons to either play again, or return to the menu screen.
 ### Parameters used on init(): ###
 * `size` is the size of the view bounds passed in by the `GameViewController`.
 */
class GameLostScene: SKScene, GKGameCenterControllerDelegate {
    ///  Delegate to handle the displaying of game scenes.
    var gameSceneDelegate: GameSceneDelegate?
    /// "GameItems" texture atlas.
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"GameItems")
    /// Summary panel to display the "Oh no! You ran out of time" text.
    private var summaryPanel = SKSpriteNode()
    /// Play again button sprite.
    private var playAgainButton = SKSpriteNode()
    /// Menu button sprite.
    private var returnToMenuButton = SKSpriteNode()
    ///
    override init(size: CGSize) {
        super.init(size: size)
    }
    /// Creates a new `Background` for the scene.
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "game-bg", frameSize: frameSize)
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    /// Creates a summary panel to display text.
    func createSummaryPanel() {
        let panelTexture = textureAtlas.textureNamed("panel")
        summaryPanel = SKSpriteNode(texture: panelTexture, color: UIColor.gray, size:CGSize(width: 520, height: 130) )
        summaryPanel.position = CGPoint(x: self.frame.midX, y: self.frame.midY+75 )
        summaryPanel.zPosition = 2;
        self.addChild(summaryPanel)
    }
    /// Creates a play again button sprite using `Button`.
    func createPlayAgainButton() {
        playAgainButton = Button(
            imageName: "purple-btn-long",
            notificationAction: "PlayAgainButtonPressed",
            size: CGSize(width: 295, height: 50),
            position: CGPoint(x: self.frame.midX, y: self.frame.midY-45 )
        )
        playAgainButton.name = "play-again-button"
        self.addChild(playAgainButton)
    }
    /// Creates a menu button sprite using `Button`.
    func createReturnToMenuButton() {
        returnToMenuButton = Button(
            imageName: "purple-btn-long",
            notificationAction: "ReturnToMenuButtonPressed",
            size: CGSize(width: 295, height: 50),
            position: CGPoint(x: self.frame.midX, y: self.frame.midY-120 )
        )
        returnToMenuButton.name = "return-to-menu-button"
        self.addChild(returnToMenuButton)
    }
    /// Text dropping down animation.
    func addTextDropDown(textNode: SKLabelNode) {
        textNode.run(SKEase.move(
            easeFunction: .curveTypeBounce,
            easeType: EaseType.easeTypeInOut,
            time: 0.6,
            from: CGPoint(x: 0, y: 40),
            to: textNode.position
        ))
    }
    /// Text pulsing animation.
    func addTextPulse(textNode: SKLabelNode) {
        let pulse = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.6),
            SKAction.fadeAlpha(to: 1, duration: 0.6),
        ])
        textNode.run(SKAction.repeatForever(pulse))
    }
    /// Updates a given sprite with new text and an optional animation. This is used for displaying text on buttons as well as the summary panel.
    func addTextToSprite(sprite: SKSpriteNode, text: String, name: String, addPulse: Bool, dropDown: Bool) {
        let textNode = SKLabelNode(fontNamed: "Arial-BoldMT")
        textNode.text = text
        textNode.name = name
        textNode.verticalAlignmentMode = .center
        textNode.position = CGPoint(x: 0, y: 0)
        textNode.zPosition = 5
        textNode.fontSize = 30
        
        if (dropDown) {
            addTextDropDown(textNode: textNode)
        }
        
        if (addPulse) {
            addTextPulse(textNode: textNode)
        }
        sprite.addChild(textNode)
    }
    /// When the scene loads, this method creates and displays all the elements in the scene.
    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
        
        createBackground()
        createSummaryPanel()
        createPlayAgainButton()
        createReturnToMenuButton()
        addTextToSprite(sprite: summaryPanel, text: "Oh no! You ran out of time.", name: "panel", addPulse: false, dropDown: true)
        addTextToSprite(sprite: playAgainButton, text: "Play again", name: "play-again-button", addPulse: true, dropDown: false)
        addTextToSprite(sprite: returnToMenuButton, text: "Return to menu", name: "return-to-menu-button", addPulse: false, dropDown: false)
    }
    /// Detect button taps switch to either menu or game scenes using the `GameSceneDelegate`.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if touchedNode.name == "play-again-button" {
                self.gameSceneDelegate?.gamePlayScene()
            }
            if touchedNode.name == "return-to-menu-button" {
                self.gameSceneDelegate?.menuScene()
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



