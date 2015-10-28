//
//  SpiralIllusionScene.swift
//  Spiral Illusion
//
//  Created by Hal Mueller on 10/23/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit

class SpiralIllusionScene: SKScene {
    let definition: SpiralIllusionDefinition
	
	init(definition: SpiralIllusionDefinition, size: CGSize) {
		self.definition = definition
		super.init(size: size)
		
		self.backgroundColor = definition.backgroundColor
		
		let center = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
		
		//		let labelNode = SKLabelNode(text: String(definition.numberOfRings))
		//        labelNode.position = center
		//		self.addChild(labelNode)
		
		let assumedSize = Double(min(self.frame.width, self.frame.height) * 0.9)
		let ringSpacing = assumedSize / 2.0 / Double(definition.numberOfRings)
		for ringNumber in 0..<definition.numberOfRings {
			let radius = Double(ringNumber + 1) * ringSpacing
			let circumference = 2.0 * radius * M_PI
			let idealNumberOfSquares = Int(circumference/(definition.squareSize + definition.squareSeparation))
			let numberOfSquares: Int
			if idealNumberOfSquares % 2 == 1 {
				numberOfSquares = idealNumberOfSquares - 1
			}
			else {
				numberOfSquares = idealNumberOfSquares
			}
			let squareSpacingRadians = 2.0 * M_PI / Double(numberOfSquares)
			//			print ("ring", ringNumber, radius, circumference, numberOfSquares, squareSpacingRadians)
			let ringNode = SKNode()
			for squareNumber in 0 ..< numberOfSquares {
				let squareNode = SKShapeNode(rectOfSize: CGSize(width: definition.squareSize, height: definition.squareSize))
				let theta = Double(squareNumber) * squareSpacingRadians
				//				print (theta)
				squareNode.position = CGPoint(x: radius * cos(theta), y: radius * sin(theta))
				squareNode.antialiased = true
				if squareNumber % 2 == 0 {
					squareNode.strokeColor = definition.evenColor
				}
				else {
					squareNode.strokeColor = definition.oddColor
				}
				squareNode.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(1.0 * (definition.innerRingRotationRate + Double(ringNumber)*definition.ringRotationRateIncrement)), duration: definition.rotationDuration)))
				squareNode.zRotation = CGFloat(theta)
				ringNode.addChild(squareNode)
			}
			ringNode.position = center
			ringNode.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(definition.innerRingRotationRate + Double(ringNumber)*definition.ringRotationRateIncrement), duration: definition.rotationDuration)))
			scene?.addChild(ringNode)
		}
	}

	override convenience init(size: CGSize) {
		self.init(definition: SpiralIllusionDefinition(), size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}