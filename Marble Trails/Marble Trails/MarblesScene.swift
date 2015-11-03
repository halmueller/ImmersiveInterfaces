//
//  MarblesScene.swift
//  Marble Trails
//
//  Created by Hal Mueller on 11/2/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit
import CoreMotion

class MarblesScene: SKScene {

    var motionManager: CMMotionManager?
    var showTrails: Bool = true

    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMoveToView(view: SKView) {
        motionManager = CMMotionManager()
        motionManager?.startDeviceMotionUpdatesUsingReferenceFrame(.XTrueNorthZVertical)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)

            let marbleSprite = SKShapeNode(circleOfRadius: 10.0)
            marbleSprite.physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
            marbleSprite.physicsBody?.affectedByGravity = true
            marbleSprite.physicsBody?.dynamic = true
            marbleSprite.fillColor = SKColor.yellowColor()
            marbleSprite.position = location
            if (showTrails) {
                let emitter = SKEmitterNode()
                emitter.particleTexture = SKTexture(imageNamed: "spark")
                emitter.targetNode = self
                emitter.particleBirthRate = 100
                emitter.particleAlphaSpeed = -1.0
                emitter.particleLifetime = 2
                emitter.particleScale = 0.2
                marbleSprite.addChild(emitter)
            }
            self.addChild(marbleSprite)
        }
    }

    override func update (currentTime: NSTimeInterval) {
        if let motion = motionManager?.deviceMotion {
            let gravity = motion.gravity
            //			let attitude = motion.attitude
            //			print ("attitude", attitude.pitch, attitude.roll, attitude.yaw)
            let adjustment = 1.0
            self.physicsWorld.gravity.dx = CGFloat(adjustment * gravity.x)
            self.physicsWorld.gravity.dy = CGFloat(adjustment * gravity.y)
        }
    }
}
