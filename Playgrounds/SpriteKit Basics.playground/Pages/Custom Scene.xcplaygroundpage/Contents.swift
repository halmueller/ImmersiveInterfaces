//: ## Custom SKScene subclass
//: [TOC](TOC) - [Previous](@previous) - [Next](@next)

import SpriteKit
import XCPlayground

class HelloWorldScene: SKScene {
    override func didMoveToView(view: SKView) {
		backgroundColor = SKColor.greenColor()

		let helloNodeName = "helloNode"
        let helloNode = SKLabelNode()
        helloNode.text = "Hello, World!"
        helloNode.name = helloNodeName
        helloNode.fontSize = 32
        helloNode.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)/2.0)
        addChild(helloNode)
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        helloNode.runAction(SKAction.repeatActionForever(action))
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(10 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if let helloNode = self.childNodeWithName(helloNodeName) {
                print("time expired, saying goodbye")
                helloNode.name = nil
                let moveUp = SKAction.moveByX(0.0, y: 100.0, duration: 5.0)
                let zoom = SKAction.scaleTo(2.0, duration: 5.0)
                let fadeAway = SKAction.fadeOutWithDuration(5.0)
                let remove = SKAction.removeFromParent()
                let moveSequence = SKAction.sequence([moveUp, zoom, fadeAway, remove])
                helloNode.runAction(moveSequence, completion: {
                    print("removal complete")
                })
            }
            
        }
    }
    override func update(currentTime: CFTimeInterval) {
    }
}

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 638))
let scene = HelloWorldScene(size: CGSize(width: 400.0, height: 200.0))
scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

//: [Next](@next)
