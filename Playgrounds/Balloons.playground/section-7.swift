let BalloonCategory: UInt32 = 1 << 1
configureBalloonPhysics = { balloon in
    balloon.physicsBody = SKPhysicsBody(texture: balloon.texture!, size: balloon.size)
    balloon.physicsBody!.linearDamping = 0.5
    balloon.physicsBody!.mass = 0.1
    balloon.physicsBody!.categoryBitMask = BalloonCategory
    balloon.physicsBody!.contactTestBitMask = BalloonCategory
}
