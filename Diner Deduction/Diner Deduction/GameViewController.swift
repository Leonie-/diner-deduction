
import UIKit
import SpriteKit

///Controls the main game scenes in co-ordination with `GameSceneDelegate`.
class GameViewController: UIViewController, GameSceneDelegate {

    private var skView: SKView!
    
    /// Controls what game scene we are currently displaying
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        skView = self.view as! SKView
        
        // Ignore drawing order of child nodes to increase performance
        skView.ignoresSiblingOrder = true
        
        // For debugging purposes check that nodes are being correctly destroyed
        // Remove before publishing
        
        // skView.showsFPS = true
        // skView.showsNodeCount = true
        
        let menuScene = MenuScene(size: skView.bounds.size)
        menuScene.scaleMode = .aspectFill
        skView.presentScene(menuScene)
        menuScene.gameSceneDelegate = self
    }
    
    /// Displays the menu scene using a delegate
    func menuScene() {
        let menuScene = MenuScene(size: view.bounds.size)
        skView.presentScene(menuScene)
        menuScene.gameSceneDelegate = self
    }
    
    /// Displays the game play scene using a delegate
    func gamePlayScene() {
        let gamePlayScene = GamePlayScene(size: view.bounds.size)
        skView.presentScene(gamePlayScene)
        gamePlayScene.gameSceneDelegate = self
    }
    
    /// Displays the game won scene using a delegate
    func gameWonScene(previousGuesses: Int) {
        let gameWonScene = GameWonScene(size: view.bounds.size)
        gameWonScene.userData = NSMutableDictionary()
        gameWonScene.userData?["numberOfGuesses"] = previousGuesses
        skView.presentScene(gameWonScene)
        gameWonScene.gameSceneDelegate = self
    }
    
    /// Displays the game lost scene using a delegate
    func gameLostScene() {
        let gameLostScene = GameLostScene(size: view.bounds.size)
        skView.presentScene(gameLostScene)
        gameLostScene.gameSceneDelegate = self
    }
    
    /// Ensure the game autorotates
    override var shouldAutorotate: Bool {
        return true
    }
    
    /// Ensure the game is always set to landscape
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    /// Release any cached data, images, etc that aren't in use
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Always hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
