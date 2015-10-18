//: ## Hello World
//: [TOC](TOC) - [Previous](@previous) - [Next](@next)
import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 638))
let scene = SKScene(size: CGSize(width: 400.0, height: 200.0))
scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

//: #### And now a Hello World node:

scene.backgroundColor = SKColor.redColor()

let helloNode = SKLabelNode(fontNamed: "Marker Felt")
helloNode.text = "Hello, World!"
helloNode.fontSize = 32
helloNode.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame))
scene.addChild(helloNode)


//: [Next](@next)
