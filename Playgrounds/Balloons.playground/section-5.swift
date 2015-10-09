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
