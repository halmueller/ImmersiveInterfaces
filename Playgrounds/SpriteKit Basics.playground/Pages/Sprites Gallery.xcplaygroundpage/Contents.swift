//: [TOC](TOC) - [Previous](@previous) - [Next](@next)
import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 1038))
let scene = SKScene(size: CGSize(width: 425.0, height: 300.0))
scene.backgroundColor = SKColor.blueColor()

scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

let spaceshipNode = SKSpriteNode(imageNamed: "rocket.png")
spaceshipNode.setScale(0.1)
print(spaceshipNode.size)

let labelNode = SKLabelNode(fontNamed: "Marker Felt")
labelNode.text = "Hello, World!"
labelNode.fontSize = 12
labelNode.verticalAlignmentMode = .Center

let circleNode = SKShapeNode(circleOfRadius: 12.0)

let ellipseNode = SKShapeNode(ellipseInRect: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 30.0))
ellipseNode.strokeColor = SKColor.magentaColor()
//ellipseNode.fillColor = SKColor.magentaColor()

let wobblingSpaceship = spaceshipNode.copy() as! SKSpriteNode
wobblingSpaceship.zRotation = CGFloat(-1.0 * M_PI_4)
let rotate = SKAction.rotateByAngle(CGFloat(M_PI_2), duration:5)
let rotateBack = rotate.reversedAction()
let wobble = SKAction.sequence([rotate, rotateBack])
wobblingSpaceship.runAction(SKAction.repeatActionForever(wobble))

let wobblingToo = wobblingSpaceship.copy() as! SKSpriteNode
wobblingToo.anchorPoint = CGPointMake(0.5, 0.0)

let thetas = 0.0.stride(through: M_PI * 3.0, by: 1.0)
var sines = thetas.map() {
	CGPoint(x: 10.0 * $0, y: 10.0 * sin($0))
}
let graphNode = SKShapeNode(points: &sines, count: sines.count)
graphNode.glowWidth = 5.0
graphNode.strokeColor = SKColor.greenColor()

//: ### Pig textures from http://www.raywenderlich.com/80586/make-line-drawing-game-sprite-kit-swift
let textures = [SKTexture(imageNamed:"pig_1"), SKTexture(imageNamed:"pig_2"), SKTexture(imageNamed:"pig_3")]
let moveAnimation = SKAction.animateWithTextures(textures, timePerFrame:0.2)
let pigNode = SKSpriteNode(imageNamed: "pig_1")
pigNode.runAction(SKAction.repeatActionForever(moveAnimation))

let pulseNode = SKShapeNode(rectOfSize: CGSize(width: 8.0, height: 8.0), cornerRadius: 2.0)
let fadeDuration = 2.0
let fade = SKAction.group([SKAction.scaleBy(5.0, duration: fadeDuration), SKAction.fadeAlphaBy(-0.9, duration: fadeDuration)])
let reset = SKAction.group([SKAction.scaleTo(1.0, duration: 0.0), SKAction.fadeAlphaTo(1.0, duration: 0.0)])
let sequence = SKAction.sequence([fade, reset])
pulseNode.runAction(SKAction.repeatActionForever(sequence))

let wtfNode = SKLabelNode(text: "?")
wtfNode.verticalAlignmentMode = .Center
wtfNode.runAction(SKAction.repeatActionForever(sequence))

let redNode = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 15.0, height: 15.0))
let magentaNode = SKSpriteNode(color: SKColor.magentaColor(), size: CGSize(width: 25.0, height: 5.0))


let sampleNodes = [labelNode, circleNode, ellipseNode, spaceshipNode, wobblingSpaceship, wobblingToo, pigNode, pulseNode, wtfNode, graphNode, redNode, magentaNode]
var row = 0
var column = 0
let numberOfColumns = 3
let leftOffset = 25.0
let bottomOffset = 25.0
let rowSpacing = 100.0
let columnSpacing = 130.0
for node in sampleNodes {
	let y = CGFloat(Double(row) * rowSpacing + bottomOffset)
	let x = CGFloat(Double(column) * columnSpacing + leftOffset)
	if (++column >= numberOfColumns) {
		row++
		column = 0
	}
	node.position = CGPointMake(x, y)
	scene.addChild(node)
}


//: [Next](@next)
