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
        summaryPanel = SKSpriteNode(texture: panelTexture, color: UIColor.gray, size:CGSize(width: 540, height: 130) )
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


