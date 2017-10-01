
import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let view = self.view as! SKView
        
        // Ignore drawing order of child nodes to increase performance
        view.ignoresSiblingOrder = true
        
        // For debugging purposes - remove before publishing
        view.showsFPS = true
        view.showsNodeCount = true
        
        let menuScene = MenuScene()
        menuScene.size = view.bounds.size
        view.presentScene(menuScene)
        
//        let musicPath = Bundle.main.path(forResource: "Sound/BackgroundMusic.m4a", ofType: nil)!
//        let url = URL(fileURLWithPath: musicPath)
        
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
