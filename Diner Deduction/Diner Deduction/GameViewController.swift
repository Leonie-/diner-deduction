
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let menuScene = MenuScene()
//        let menuScene = CompletionScene()
        let view = self.view as! SKView
        // Ignore drawing order of child nodes to increase performance
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        menuScene.size = view.bounds.size
        view.presentScene(menuScene)
        
//        let musicPath = Bundle.main.path(forResource: "Sound/BackgroundMusic.m4a", ofType: nil)!
//        let url = URL(fileURLWithPath: musicPath)
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                // Size our scene to fit the view exactly:
//                scene.size = view.bounds.size
//                // Show the new scene:
//                view.presentScene(scene)
//            }
//            
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
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
