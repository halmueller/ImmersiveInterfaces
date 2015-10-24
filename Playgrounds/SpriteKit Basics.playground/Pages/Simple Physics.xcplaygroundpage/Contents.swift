//: [TOC](TOC) - [Previous](@previous) - [Next](@next)

import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 800))
let scene = SKScene(size: CGSize(width: 425.0, height: 400.0))
scene.backgroundColor = SKColor.yellowColor()

scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)
sceneView.showsPhysics = true

scene.physicsWorld.gravity.dy = -1.0

XCPlaygroundPage.currentPage.liveView = sceneView

let ground = SKSpriteNode(texture: SKTexture(imageNamed: "ground"))
print(ground)
let GroundCategory: UInt32 = 1 << 2
ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.size)
ground.physicsBody?.affectedByGravity = false
ground.physicsBody?.dynamic = false
ground.anchorPoint = CGPoint(x:0.5, y:0.0)
ground.position = CGPoint(x:0, y:0)
scene.addChild(ground)

let images = [
	"blue", "heart-blue", "star-blue",
	"green", "star-green", "heart-pink",
	"heart-red", "orange", "red",
	"star-gold", "star-pink", "star-red",
	"yellow"
]
let textures: [SKTexture] = images.map { SKTexture(imageNamed: "balloon-\($0)") }

var configureBalloonPhysics: ((balloon: SKSpriteNode) -> Void)?
func createRandomBalloon() -> SKSpriteNode {
	let choice = Int(arc4random_uniform(UInt32(textures.count)))
	let balloon = SKSpriteNode(texture: textures[choice])
	balloon.setScale(0.3)
	configureBalloonPhysics?(balloon: balloon)
	
	return balloon
}
let BalloonCategory: UInt32 = 1 << 1
configureBalloonPhysics = { balloon in
	balloon.physicsBody = SKPhysicsBody(texture: balloon.texture!, size: balloon.size)
	balloon.physicsBody!.linearDamping = 0.8
	balloon.physicsBody!.mass = 0.1
	balloon.physicsBody!.categoryBitMask = BalloonCategory
	balloon.physicsBody!.contactTestBitMask = BalloonCategory
}

let makeBalloon = SKAction.runBlock {
	let balloon = createRandomBalloon()
	balloon.position = CGPoint(x:150.0 + Double(arc4random_uniform(100)), y:400.0)
	print (balloon.texture)
	scene.addChild(balloon)
}
scene.runAction(SKAction.repeatActionForever(SKAction.sequence([makeBalloon,SKAction.waitForDuration(1.0)])))


