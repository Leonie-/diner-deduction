import SpriteKit
import GameKit

class MenuScene: SKScene, GKGameCenterControllerDelegate {
    
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"MenuScreen")
    var startButton = SKSpriteNode()
    var quitButton = SKSpriteNode()
    
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "menu-bg", frameSize: frameSize )
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red:0.60, green:0.50, blue:0.69, alpha:1.0)
    }
    
    func createLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: 390, height: 295)
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY+20 )
        logo.zPosition = 1
        self.addChild(logo)
    }
    
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
    
    func createQuitButton() {
        let quitButton = SKSpriteNode(imageNamed: "quit-btn")
        quitButton.size = CGSize(width: 53, height: 53)
        quitButton.anchorPoint = CGPoint(x:1, y: 1)
        quitButton.position = CGPoint(x: self.frame.width-15, y: self.frame.height-15 )
        quitButton.zPosition = 4;
        quitButton.name = "quit-button"
        self.addChild(quitButton)
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
        createLogo()
        createQuitButton()
        createStartButton()
        addTextToSprite(sprite: startButton, text: "Start game", name: "start-button", addPulse: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if touchedNode.name == "start-button" {
                self.view?.presentScene(GameScene(size: self.size))
            }
            if touchedNode.name == "quit-button" {
                UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

