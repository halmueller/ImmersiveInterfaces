//
//  CollisionDetectionScene.swift
//  Collision Detection Bostock
//
//  Created by Hal Mueller on 11/2/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit
import GameplayKit

class CollisionDetectionScene: SKScene {
    var circles: [SKShapeNode]?

    override init(size: CGSize) {
        super.init(size: size)

        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity.dx = CGFloat(0)
        self.physicsWorld.gravity.dy = CGFloat(0)

        let gravityNode = SKFieldNode.radialGravityField()
        gravityNode.minimumRadius = 3.0
        gravityNode.falloff = 1.2
        gravityNode.strength = 3
        gravityNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(gravityNode)

        var circleNodes: [SKShapeNode] = []
        let colors = [SKColor(red:0.11, green:0.38, blue:0.65, alpha:1.0),
			SKColor(red:0.15, green:0.58, blue:0.13, alpha:1.0),
			SKColor(red:0.99, green:0.41, blue:0.06, alpha:1.0)]
        for index in 0..<200 {
            let radius = CGFloat(index % 12 + 6)
            let marbleSprite = SKShapeNode(circleOfRadius: radius)

            marbleSprite.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            marbleSprite.physicsBody?.affectedByGravity = true
            marbleSprite.physicsBody?.dynamic = true
            marbleSprite.physicsBody?.charge = 0.05

            marbleSprite.strokeColor = colors[index % colors.count]
            marbleSprite.fillColor = marbleSprite.strokeColor
            marbleSprite.position = CGPoint(x: CGRectGetMidX(self.frame), y: 1.2 * CGRectGetMidY(self.frame))
            circleNodes.append(marbleSprite)
        }
        self.circles = circleNodes
        for node in circleNodes {
            self.addChild(node)
        }
        self.backgroundColor = SKColor.whiteColor()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let chargeNode = SKFieldNode.electricField()
            chargeNode.strength = 3
            chargeNode.falloff = 0.5
            chargeNode.position = touch.locationInNode(self)
            chargeNode.name = "ChargeNode"
            let labelNode = SKShapeNode(circleOfRadius: 10)
            labelNode.fillColor = SKColor.blackColor()
            chargeNode.addChild(labelNode)
            self.addChild(chargeNode)
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let previousLocation = touch.previousLocationInNode(self)
            let allNodes = self.nodesAtPoint(previousLocation)
            let chargeNodes = allNodes.filter({$0.name == "ChargeNode"})
            // probably just one
            for chargeNode in chargeNodes {
                chargeNode.position = touch.locationInNode(self)
            }
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        enumerateChildNodesWithName("//ChargeNode") { node, stop in
            node.removeFromParent()
        }
    }
}
