import SpriteKit
import GameKit

class GameWonScene: SKScene, GKGameCenterControllerDelegate {
    
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"GameItems")
    
    private var summaryPanel = SKSpriteNode()
    private var playAgainButton = SKSpriteNode()
    private var returnToMenuButton = SKSpriteNode()
    
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "game-bg", frameSize: frameSize)
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    
    func createSummaryPanel() {
        let panelTexture = textureAtlas.textureNamed("panel")
        summaryPanel = SKSpriteNode(texture: panelTexture, color: UIColor.gray, size:CGSize(width: 520, height: 130) )
        summaryPanel.position = CGPoint(x: self.frame.midX, y: self.frame.midY+75 )
        summaryPanel.zPosition = 2;
        self.addChild(summaryPanel)
    }
    
    func createSparkles() {
        let sparkles = SKEmitterNode(fileNamed: "Sparkles.sks")
        sparkles?.particlePosition = CGPoint(x: self.frame.midX, y: self.frame.midY )
        self.addChild(sparkles!)
    }
    
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
    
    func addTextToSprite(sprite: SKSpriteNode, text: String, name: String, addPulse: Bool) {
        let textNode = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
        textNode.text = text
        textNode.name = name
        textNode.verticalAlignmentMode = .center
        textNode.position = CGPoint(x: 0, y: 0)
        textNode.zPosition = 5
        textNode.fontSize = 30
        
        if (addPulse) {
            let pulse = SKAction.sequence([
                SKAction.fadeAlpha(to: 0.6, duration: 0.8),
                SKAction.fadeAlpha(to: 1, duration: 0.8),
            ])
            textNode.run(SKAction.repeatForever(pulse))
        }
        sprite.addChild(textNode)
    }
    
    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
    
        createBackground()
        createSummaryPanel()
        createSparkles()
        createPlayAgainButton()
        createReturnToMenuButton()
        addTextToSprite(sprite: summaryPanel, text: "Yes! You completed the pizza in time", name: "panel", addPulse: false)
        addTextToSprite(sprite: playAgainButton, text: "Play again", name: "play-again-button", addPulse: false)
        addTextToSprite(sprite: returnToMenuButton, text: "Return to menu", name: "return-to-menu-button", addPulse: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if touchedNode.name == "play-again-button" {
                self.view?.presentScene(GamePlayScene(size: self.size))
            }
            if touchedNode.name == "return-to-menu-button" {
                self.view?.presentScene(MenuScene(size: self.size))
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}


