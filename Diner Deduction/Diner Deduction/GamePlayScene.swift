
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift
/**
 The main gameplay scene sets up a new game and starts the timer. It gets the Model for the game from the `IngredientsListGenerator` and the `Customer`. It displays all the View elements for the game: a notification bar with information, the countdown timer, the ingredients, a pizza to drag the ingredients onto, a submit button, and previous guesses (if any have been made).
 ### Parameters used on init(): ###
 * `size` is the size of the view bounds passed in by the `GameViewController`.
 */
class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    ///  Delegate to handle the displaying of game scenes.    
    var gameSceneDelegate: GameSceneDelegate?
    /// "GameItems" texture atlas.
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    /// The `GameSprite` that the player has most recently interacted with.
    private var selectedNode: GameSprite!
    /// Sets up a new `Customer` when initialised.
    static var customer: Customer!
    /// Sets up a new `NotificationBar` when initialised.
    static var notificationBar: NotificationBar!
    /// Sets up a new `PreviousGuesses` when initialised.
    static var previousGuesses: PreviousGuesses!
    /// Sets up the countdown text.
    var countDownText: SKLabelNode!
    /// Sets up a new `Timer` when initialised.
    var timer: Timer!
    /// The length of the game - currently always a minute.
    var secondsLeft = 60
    ///
    override init(size: CGSize) {
        super.init(size: size)
    }
    /// When the scene loads, a randomised set of ingredients is generated using `IngredientsListGenerator`, then the `Customer` selects three of them as the correct answer (to form the Model). It also displays all the View elements in the scene (the pizza, the ingredients, the timer, etc.) and starts a `Timer`. It listens for a "GameWon" notification, to move to the game won scene using the `GameSceneDelegate`.
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
    /// Creates a new `Background`.
    func createBackground() {
        let frameSize = CGSize(width: self.frame.width, height: self.frame.height)
        let background = Background(textureName: "game-bg", frameSize: frameSize)
        self.addChild(background.sprite)
        self.backgroundColor = UIColor(red: 0.5216, green: 0.8196, blue: 0.8627, alpha: 1.0)
    }
    /// Creates a view for the countdown timer.
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
    /// Create `PreviousGuesses`.
    func createPreviousGuesses() {
        GamePlayScene.previousGuesses = PreviousGuesses()
        self.addChild((GamePlayScene.previousGuesses?.section)!)
    }
    /// Create a `NotificationBar`.
    func createNotificationBar(totalIngredients: Int) {
        GamePlayScene.notificationBar = NotificationBar(frameWidth: self.frame.width, frameHeight: self.frame.height, totalIngredients: totalIngredients)
        self.addChild((GamePlayScene.notificationBar?.bar)!)
        self.addChild((GamePlayScene.notificationBar?.message)!)
    }
    /// Create a `Pizza`.
    func createPizza(totalIngredients: Int) {
        let pizza = Pizza( frame: self.frame, totalIngredients: totalIngredients)
        self.addChild(pizza)
    }
    /// Iterate through an array of ingredients and create views for each.
    func createIngredients(ingredients: Array<(String,CGFloat,CGFloat)>) {
        for (type, offsetX, offsetY) in ingredients {
            createIngredient(ingredient: type, offsetX: offsetX, offsetY: offsetY)
        }
    }
    /// Create `Ingredient`.
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
    /// Create a submit `Button`.
    func createSubmitButton() {
        let submitButton = Button(
            imageName: "submit-btn",
            notificationAction: "SubmitButtonPressed",
            size: CGSize(width: 142, height: 38),
            position: CGPoint(x: self.frame.width-100, y: 40)
        )
        self.addChild(submitButton)
    }
    /// Convert a time interval into "00:00" string format.
    func timeToString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    /// Update the countdown timer text and use the `GameSceneDelegate` to end the game and switch to the `GameLostScene` if time has run out.
    func updateTimer() {
        if secondsLeft < 1 {
            timer.invalidate()
            self.gameSceneDelegate?.gameLostScene()
        }
        else {
            secondsLeft -= 1
            countDownText.text = timeToString(time: TimeInterval(secondsLeft))
        }
    }
    /// End the game and switch to the `GameWonScene` passing in the number of guesses it took, using the `GameSceneDelegate`.
    func whenGameWon() {
        let previousGuesses: Int = GamePlayScene.previousGuesses.total
        self.gameSceneDelegate?.gameWonScene(previousGuesses: previousGuesses)
    }
    /// Handle tap behaviour. If the tap is on a `GameSprite`, then update `selectedNode` accordingly and call its `.onTouch()` function.
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
    /// Handle drag behaviour. If `selectedNode` is set, call its `.onDrag()` function.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            if (selectedNode != nil) {
                selectedNode.onDrag(touch: touch)
            }
        }
    }
    /// Handle drop behaviour. If `selectedNode` is set, call its `.onDrop()` function.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (selectedNode != nil) {
            selectedNode.onDrop()
            selectedNode = GameSpriteNull()
        }
    }
    /// Handle touch cancelled behaviour. If `selectedNode` is set, call its `.onDrop()` function.
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (selectedNode != nil) {
            selectedNode.onDrop()
            selectedNode = GameSpriteNull()
        }
    }
    /// Called before each frame is rendered. Not currently used.
    override func update(_ currentTime: TimeInterval) {}
    
    /// Satisfy the `NSCoder` required init, as this class inherits from others.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
/// Contains information for collision detection.
enum PhysicsCategory:UInt32 {
    ///
    case ingredient = 1
    ///
    case pizza = 2
}
