import SpriteKit
import GameKit

/**
 This scene appears when the player has correctly guessed the ingredients requested by the customer. It has a panel displaying different text depending on the number of guesses it took to win, and a sparkle particle effect in the background. The user has the option of playing again or returning to the menu.
 ### Parameters used on init(): ###
 * `size` is the size of the view bounds passed in by the `GameViewController`.
 */
class GameWonScene: SKScene, GKGameCenterControllerDelegate {
    ///  Delegate to handle the displaying of game scenes.
    var gameSceneDelegate: GameSceneDelegate?
    /// "GameItems" texture atlas.
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"GameItems")
    /// Summary panel to display the game won text.
    private var summaryPanel = SKSpriteNode()
    /// Play again button sprite.
    private var playAgainButton = SKSpriteNode()
    /// Menu button sprite.
    private var returnToMenuButton = SKSpriteNode()
    ///
    override init(size: CGSize) {
        super.init(size: size)
    }
    /// When the scene loads, this method creates and displays all the elements in the scene.
    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
        
        createBackground()
        createSummaryPanel()
        createSparkles()
        createPlayAgainButton()
        createReturnToMenuButton()
        addTextToSummaryPanel()
        addTextToSprite(sprite: playAgainButton, text: "Play again", name: "play-again-button", position: CGPoint(x: 0, y: 0) )
        addTextToSprite(sprite: returnToMenuButton, text: "Return to menu", name: "return-to-menu-button", position: CGPoint(x: 0, y: 0))
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
        summaryPanel = SKSpriteNode(texture: panelTexture, color: UIColor.gray, size:CGSize(width: 540, height: 130) )
        summaryPanel.position = CGPoint(x: self.frame.midX, y: self.frame.midY+75 )
        summaryPanel.zPosition = 2;
        self.addChild(summaryPanel)
    }
    /// Creates sparkles particle effect.
    func createSparkles() {
        let sparkles = SKEmitterNode(fileNamed: "Sparkles.sks")
        sparkles?.particlePosition = CGPoint(x: self.frame.midX, y: self.frame.midY )
        self.addChild(sparkles!)
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
    /// Updates a given sprite with new text.
    func addTextToSprite(sprite: SKSpriteNode, text: String, name: String, position: CGPoint) {
        let textNode = SKLabelNode(fontNamed: "Arial-BoldMT")
        textNode.text = text
        textNode.name = name
        textNode.verticalAlignmentMode = .center
        textNode.position = position
        textNode.zPosition = 5
        textNode.fontSize = 28
        sprite.addChild(textNode)
    }
    /// Updates the summary panel with text based on the number of guesses it took to win.
    func addTextToSummaryPanel() {
        var panelText1 = "You got it right immediately!"
        var panelText2 = "Well done."
        
        if let totalGuesses = self.userData?["numberOfGuesses"] as! Int! {
            if totalGuesses > 3 {
                panelText1 = "Hmm. You completed the pizza in \(totalGuesses)"
                panelText2 = "tries. Maybe you need more practice?"
            }
            else if totalGuesses > 1 {
                panelText1 = "Yes! You completed the pizza"
                panelText2 = "in \(totalGuesses) guesses."
            }
            
        }
        addTextToSprite(sprite: summaryPanel, text: panelText1, name: "summary-panel", position: CGPoint(x: 0, y: 20))
        addTextToSprite(sprite: summaryPanel, text: panelText2, name: "summary-panel", position: CGPoint(x: 0, y: -20))
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


