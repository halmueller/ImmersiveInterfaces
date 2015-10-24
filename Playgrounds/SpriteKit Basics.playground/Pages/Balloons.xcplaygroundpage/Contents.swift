//: [TOC](TOC) - [Previous](@previous) - [Next](@next)

import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 400))
let scene = SKScene(size: CGSize(width: 425.0, height: 200.0))
scene.backgroundColor = SKColor.brownColor()

scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

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
	configureBalloonPhysics?(balloon: balloon)
	
	return balloon
}
let BalloonCategory: UInt32 = 1 << 1
configureBalloonPhysics = { balloon in
	balloon.physicsBody = SKPhysicsBody(texture: balloon.texture!, size: balloon.size)
	balloon.physicsBody!.linearDamping = 0.8
	balloon.physicsBody!.mass = 0.0
	balloon.physicsBody!.categoryBitMask = BalloonCategory
	balloon.physicsBody!.contactTestBitMask = BalloonCategory
}

let GroundCategory: UInt32 = 1 << 2

let ground = SKSpriteNode(texture: SKTexture(imageNamed: "ground"))
print(ground)
ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.size)
ground.position = CGPoint(x:0, y:100)
//scene.childNodeWithName("//ground")!
scene.addChild(ground)
ground.physicsBody!.categoryBitMask = GroundCategory
//ground.affectedByGravity = false
//ground.allowsRotation = false
print(ground)

for _ in 1...5 {
	let balloon = createRandomBalloon()
	balloon.position = CGPoint(x:200.0, y:200.0)
	print (balloon.texture)
	scene.addChild(balloon)
}

