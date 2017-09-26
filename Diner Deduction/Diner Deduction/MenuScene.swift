import SpriteKit
import GameKit

class MenuScene: SKScene, GKGameCenterControllerDelegate {
    
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"MenuScreen")
    var startButton = SKSpriteNode()
    
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "menu-bg", frameSize: frameSize )
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    
    func createLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: 300, height: 227)
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY+20 )
        logo.zPosition = 1
        self.addChild(logo)
    }
    
    func createStartButton() {
        startButton = Button(
            imageName: "blue-btn",
            notificationAction: "StartButtonPressed",
            size: CGSize(width: 190, height: 50),
            position: CGPoint(x: self.frame.midX, y: self.frame.midY-90 )
        )
        startButton.name = "start-button"
        self.addChild(startButton)
    }
    
    func addTextToStartButton() {
        let startButtonText = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
        startButtonText.text = "Start Game"
        startButtonText.name = "start-button"
        startButtonText.verticalAlignmentMode = .center
        startButtonText.position = CGPoint(x: 0, y: 0)
        startButtonText.zPosition = 5
        startButtonText.fontSize = 30
    
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.8),
            SKAction.fadeAlpha(to: 1, duration: 0.8),
        ])
        startButtonText.run(SKAction.repeatForever(pulseAction))

        startButton.addChild(startButtonText)
    }
    
    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
        
        createBackground()
        createLogo()
        createStartButton()
        addTextToStartButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if touchedNode.name == "start-button" {
                self.view?.presentScene(GameScene(size: self.size))
            }
        }
    }
    
    // This hides the game center when the user taps 'done'
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

