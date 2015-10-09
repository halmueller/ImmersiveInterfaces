let displayBalloon: (SKSpriteNode, SKNode) -> Void = { balloon, cannon in
    balloon.position = cannon.childNodeWithName("mouth")!.convertPoint(CGPointZero, toNode: scene)
    scene.addChild(balloon)
}
