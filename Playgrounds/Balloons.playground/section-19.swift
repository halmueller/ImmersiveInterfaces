let balloonPop = (1...4).map {
    SKTexture(imageNamed: "explode_0\($0)")
}

let removeBalloonAction: SKAction = SKAction.sequence([
    SKAction.animateWithTextures(balloonPop, timePerFrame: 1 / 30.0),
    SKAction.removeFromParent()
    ])
