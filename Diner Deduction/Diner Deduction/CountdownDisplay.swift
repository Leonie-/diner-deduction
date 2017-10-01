
import SpriteKit

class CountdownDisplay: SKSpriteNode {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "GameItems")
    let countDownText = SKLabelNode(fontNamed: "Arial")
    var secondsLeft: Int = 10000
    
    func timeToString(time: TimeInterval) -> String {
        print("TIME", time)
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

    func addCountdownText(text: Int) {
        countDownText.fontSize = 45
        countDownText.text = timeToString(time: TimeInterval(secondsLeft))
        countDownText.countDownText.text = "";
        countDownText.zPosition = 7;
        countDownText.horizontalAlignmentMode = .center
        countDownText.position = CGPoint(x:-42, y:-45)
        countDownText.addChild(self)
    }
    
    func updateCountdown() {
        if secondsLeft < 1 {
            NotificationCenter.default.post(name:Notification.Name("GameLost"), object: nil)
        }
        else {
            secondsLeft -= 1
            countDownText.text = timeToString(time: TimeInterval(secondsLeft))
            // countDownText.text = String(secondsLeft)
        }
    }
    
    init(frame: CGRect, gameLength: Int) {
        let size = CGSize(width: 84, height: 56)

        super.init(texture: textureAtlas.textureNamed("guess-box"), color: UIColor.clear, size: size)
        self.anchorPoint = CGPoint(x:1, y: 1)
        self.position = CGPoint(x: frame.width-5, y: frame.height-5 )
        self.zPosition = 5;
        
        secondsLeft = gameLength
        addCountdownText(text: secondsLeft)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountdown), name:Notification.Name("UpdateCountdown"),  object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
