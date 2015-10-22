let GroundCategory: UInt32 = 1 << 2
let ground = scene.childNodeWithName("//ground")!
print (ground)
ground.physicsBody!.categoryBitMask = GroundCategory
