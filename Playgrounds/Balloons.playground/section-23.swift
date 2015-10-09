class PhysicsContactDelegate: NSObject, SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        let categoryA = contact.bodyA.categoryBitMask
        let categoryB = contact.bodyB.categoryBitMask
        
        if (categoryA & BalloonCategory != 0) && (categoryB & BalloonCategory != 0) {
			contact.bodyA.node!.runAction(removeBalloonAction)
        }
    }
}

let contactDelegate = PhysicsContactDelegate()
scene.physicsWorld.contactDelegate = contactDelegate
