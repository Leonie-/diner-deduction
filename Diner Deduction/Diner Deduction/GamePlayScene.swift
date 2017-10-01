
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    
    private var selectedNode: GameSprite!
    static var customer: Customer!
    static var notificationBar: NotificationBar!
    static var previousGuesses: PreviousGuesses!
    
    var countDownText: SKLabelNode!
    var timer: Timer!
    var secondsLeft = 60
    
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "game-bg", frameSize: frameSize)
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    
    func createCountDownDisplay() {
        let countDownBox = SKSpriteNode(imageNamed: "countdown-box")
        countDownBox.size = CGSize(width: 105, height: 50)
        countDownBox.anchorPoint = CGPoint(x:1, y: 1)
        countDownBox.position = CGPoint(x: self.frame.width-5, y: self.frame.height-5 )
        countDownBox.zPosition = 5;
        
        self.addChild(countDownBox)
        
        countDownText = SKLabelNode(fontNamed: "Arial-BoldMT")
        countDownText.fontSize = 35
        countDownText.text = timeToString(time: TimeInterval(secondsLeft))
        countDownText.zPosition = 7;
        countDownText.horizontalAlignmentMode = .center
        countDownText.position = CGPoint(x:-52, y:-38)
        
        countDownBox.addChild(countDownText)
    }
    
    func createPreviousGuesses() {
        GamePlayScene.previousGuesses = PreviousGuesses()
        self.addChild((GamePlayScene.previousGuesses?.section)!)
    }
    
    func createNotificationBar(totalIngredients: Int) {
        GamePlayScene.notificationBar = NotificationBar(frameWidth: self.frame.width, frameHeight: self.frame.height, totalIngredients: totalIngredients)
        self.addChild((GamePlayScene.notificationBar?.bar)!)
        self.addChild((GamePlayScene.notificationBar?.message)!)
    }
    
    func createPizza(totalIngredients: Int) {
        let pizza = Pizza( frame: self.frame, totalIngredients: totalIngredients)
        self.addChild(pizza)
    }

    func createIngredients(ingredients: Array<(String,CGFloat,CGFloat)>) {
        for (type, offsetX, offsetY) in ingredients {
            createIngredient(ingredient: type, offsetX: offsetX, offsetY: offsetY)
        }
    }
    
    func createIngredient(ingredient: String, offsetX: CGFloat, offsetY: CGFloat) {
        let ingredient = Ingredient(
            name: ingredient,
            image: ingredient,
            size: CGSize(width:50, height:50),
            positionX: offsetX,
            positionY: offsetY
        )
        self.addChild(ingredient)
    }
    
    func createSubmitButton() {
        let submitButton = Button(
            imageName: "submit-btn",
            notificationAction: "SubmitButtonPressed",
            size: CGSize(width: 142, height: 38),
            position: CGPoint(x: self.frame.width-100, y: 40)
        )
        self.addChild(submitButton)
    }

    override func didMove(to view: SKView) {
        //position to lower left
        self.anchorPoint = .zero
        
        let totalIngredients = 3
        let ingredientsListGenerator = IngredientsListGenerator(
            totalIngredients: totalIngredients,
            arrayShuffler: ArrayShuffler()
        )
        let ingredients = ingredientsListGenerator.generate
        
        createBackground()
        GamePlayScene.customer = Customer(ingredients: ingredients, totalIngredients: totalIngredients, arrayShuffler: ArrayShuffler())
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        createCountDownDisplay()
        createPreviousGuesses()
        createNotificationBar(totalIngredients: totalIngredients)
        createPizza(totalIngredients: totalIngredients)
        createIngredients(ingredients: ingredients)
        createSubmitButton()

        
        //Handle contact in the scene
        self.physicsWorld.contactDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(whenGameWon), name:Notification.Name("GameWon"),  object: nil)
    }
    
    func timeToString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func updateTimer() {
        if secondsLeft < 1 {
            timer.invalidate()
            self.view?.presentScene(GameLostScene(size: self.size))
        }
        else {
            secondsLeft -= 1
            countDownText.text = timeToString(time: TimeInterval(secondsLeft))
        }
    }
    
    func whenGameWon() {
        let gameWonScene = GameWonScene(size: self.size)
        gameWonScene.userData = NSMutableDictionary()
        gameWonScene.userData?["numberOfGuesses"] = GamePlayScene.previousGuesses.total
        self.view?.presentScene(gameWonScene)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
    		let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if touchedNode is GameSprite {
                selectedNode = touchedNode as! GameSprite
                selectedNode.onTouch()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            if (selectedNode != nil) {
                selectedNode.onDrag(touch: touch)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (selectedNode != nil) {
            selectedNode.onDrop()
            selectedNode = GameSpriteNull()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (selectedNode != nil) {
            selectedNode.onDrop()
            selectedNode = GameSpriteNull()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

enum PhysicsCategory:UInt32 {
    case ingredient = 1
    case pizza = 2
}
