
import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate {
    
    var skView: SKView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        skView = self.view as! SKView
        
        // Ignore drawing order of child nodes to increase performance
        skView.ignoresSiblingOrder = true
        
        // For debugging purposes - remove before publishing
        // skView.showsFPS = true
        // skView.showsNodeCount = true
        
        let menuScene = MenuScene(size: skView.bounds.size)
        menuScene.scaleMode = .aspectFill
        skView.presentScene(menuScene)
        menuScene.gameSceneDelegate = self
    }
    
    func menuScene() {
        let menuScene = MenuScene(size: view.bounds.size)
        skView.presentScene(menuScene)
        menuScene.gameSceneDelegate = self
    }
    
    func gamePlayScene() {
        let gamePlayScene = GamePlayScene(size: view.bounds.size)
        skView.presentScene(gamePlayScene)
        gamePlayScene.gameSceneDelegate = self
    }
    
    func gameWonScene(previousGuesses: Int) {
        let gameWonScene = GameWonScene(size: view.bounds.size)
        gameWonScene.userData = NSMutableDictionary()
        gameWonScene.userData?["numberOfGuesses"] = previousGuesses
        skView.presentScene(gameWonScene)
        gameWonScene.gameSceneDelegate = self
    }
    
    func gameLostScene() {
        let gameLostScene = GameLostScene(size: view.bounds.size)
        skView.presentScene(gameLostScene)
        gameLostScene.gameSceneDelegate = self
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
