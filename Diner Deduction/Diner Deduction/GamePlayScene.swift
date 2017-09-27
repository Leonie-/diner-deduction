
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
    private var selectedNode: GameSprite = GameSpriteNull()
    static var customer: Customer? = nil
    static var notificationBar: NotificationBar? = nil
    static var previousGuesses: PreviousGuesses? = nil
    
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "game-bg", frameSize: frameSize)
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    
    func createPreviousGuessesTab(frameWidth: CGFloat, frameHeight: CGFloat) {
        GamePlayScene.previousGuesses = PreviousGuesses(frameWidth: self.frame.width, frameHeight: self.frame.height)
        self.addChild((GamePlayScene.previousGuesses?.label)!)
        self.addChild((GamePlayScene.previousGuesses?.tab)!)
    }
    
    func createNotificationBar(totalIngredients: Int) {
        GamePlayScene.notificationBar = NotificationBar(frameWidth: self.frame.width, frameHeight: self.frame.height, totalIngredients: totalIngredients)
        self.addChild((GamePlayScene.notificationBar?.bar)!)
        self.addChild((GamePlayScene.notificationBar?.message)!)
        
    }
    
    func createPizza(totalIngredients: Int) {
        let pizza = Pizza(
            positionX: self.frame.midX,
            positionY: self.frame.midY,
            totalIngredients: totalIngredients
        )
        self.addChild(pizza)
    }

    func createIngredients(ingredients: Array<(String,CGFloat)>) {
        for (type, offsetX) in ingredients {
            createIngredient(ingredient: type, offsetX: offsetX)
        }
    }
    
    func createIngredient(ingredient: String, offsetX: CGFloat) {
        let ingredient = Ingredient(
            name: ingredient,
            image: ingredient,
            size: CGSize(width:50, height:50),
            positionX: offsetX,
            positionY: 40
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
        let ingredients = [
            (type: "tomato", offsetX: 150 as CGFloat),
            (type: "olive", offsetX: 250 as CGFloat),
            (type: "mushroom", offsetX: 350 as CGFloat),
            (type: "pepperoni", offsetX: 450 as CGFloat)
        ];

        createBackground()
        GamePlayScene.customer = Customer(ingredients: ingredients, totalIngredients: totalIngredients, arrayShuffler: ArrayShuffler())
        
        createPreviousGuessesTab(frameWidth: self.frame.width, frameHeight: self.frame.height)
        createNotificationBar(totalIngredients: totalIngredients)
        createPizza(totalIngredients: totalIngredients)
        createIngredients(ingredients: ingredients)
        createSubmitButton()
        
        //Handle contact in the scene
        self.physicsWorld.contactDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(whenGameWon), name:Notification.Name("GameWon"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(whenGameLost), name:Notification.Name("GameLost"),  object: nil)
    }
    
    func whenGameWon() {
        self.view?.presentScene(GameWonScene(size: self.size))
    }
    
    func whenGameLost() {
        self.view?.presentScene(GameLostScene(size: self.size))
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
            selectedNode.onDrag(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode.onDrop()
        selectedNode = GameSpriteNull()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode.onDrop()
        selectedNode = GameSpriteNull()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

enum PhysicsCategory:UInt32 {
    case ingredient = 1
    case pizza = 2
}
