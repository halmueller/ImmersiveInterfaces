//
//  PlummetScene.swift
//  Plummet
//
//  Created by Hal Mueller on 10/16/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlummetScene: SKScene {
    var markerSprite: SKShapeNode!
    var centerPoint: SKShapeNode!
    
    var motionManager: CMMotionManager!
    
    func radius() -> CGFloat {
        return self.frame.size.width*0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        motionManager = CMMotionManager()
        motionManager.startDeviceMotionUpdatesUsingReferenceFrame(.XTrueNorthZVertical)
        
        let outsideCircle = SKShapeNode(circleOfRadius: self.radius())
        outsideCircle.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(outsideCircle)
        
        centerPoint = SKShapeNode(circleOfRadius: 2.0)
        centerPoint.position = outsideCircle.position
        centerPoint.fillColor = SKColor.yellowColor()
        
        markerSprite = SKShapeNode(circleOfRadius: 5.0)
        markerSprite?.fillColor = SKColor.redColor()

        self.addChild(markerSprite)
        self.addChild(centerPoint)
    }
    
    override func didFinishUpdate() {
        if let motion = motionManager.deviceMotion {
            //			let attitude = motion.attitude
            //			print ("attitude", attitude.pitch, attitude.roll, attitude.yaw)
            let gravity = motion.gravity
//            print ("gravity", gravity.x, gravity.y, gravity.z)
            
            let gravityMultiple = 100.0
            let xDelta = CGFloat(gravity.x * gravityMultiple)
            let yDelta = CGFloat(gravity.y * gravityMultiple)
            markerSprite.position = CGPointMake(centerPoint.position.x + xDelta,
                centerPoint.position.y + yDelta)
        }
    }

    override func update (currentTime: NSTimeInterval) {
    }
}
