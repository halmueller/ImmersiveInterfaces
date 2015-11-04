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
		print("init", size)
		
		self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
		self.physicsWorld.gravity.dx = CGFloat(0)
		self.physicsWorld.gravity.dy = CGFloat(0)
		
		let gravityNode = SKFieldNode.radialGravityField()
		gravityNode.minimumRadius = 3.0
		print(gravityNode.minimumRadius)
		gravityNode.falloff = 3
		gravityNode.strength = 4
		gravityNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
		self.addChild(gravityNode)
		
		let chargeNode = SKFieldNode.electricField()
		chargeNode.strength = 1.0
		chargeNode.falloff = 0.8
		chargeNode.position = CGPoint(x: CGRectGetMidX(self.frame) + 50.0, y: CGRectGetMidY(self.frame) + 50.0)
		self.addChild(chargeNode)
		
		var circleNodes: [SKShapeNode] = []
		let colors = [SKColor.redColor(), SKColor.greenColor(), SKColor.blueColor()]
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
		self.backgroundColor = SKColor.yellowColor()
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
}
