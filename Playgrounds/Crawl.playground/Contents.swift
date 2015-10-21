import SpriteKit
import XCPlayground

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 638))
let scene = SKScene(size: CGSize(width: 300.0, height: 200.0))
scene.scaleMode = .AspectFill
scene.backgroundColor = SKColor.redColor()
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

let textNode = SKLabelNode(text: "Some really long text. I wish I had used a lorem ipsum generator to make this even longer. How does CNN do it?")
textNode.fontName = "Times"
    textNode.horizontalAlignmentMode = .Left
textNode.position = CGPoint.init(x: 300.0, y: 100.0)
scene.addChild(textNode)
let action = SKAction.moveBy(CGVector(dx: -1.0*(textNode.frame.width + scene.frame.width), dy: 0.0), duration: 20.0)
textNode.runAction(action) {
    print("next headline please")
    textNode.removeFromParent()
}
print(textNode.frame.width)
