//
//  GameScene.swift
//  SpriteKit Particle System Sampler
//
//  Created by Hal Mueller on 10/27/15.
//  Copyright (c) 2015 Hal Mueller. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	let emitterTuples = [("SparkParticle.sks", "Spark"),
		("RainParticle.sks", "Rain"),
		("SnowParticle.sks", "Snow"),
		("SmokeParticle.sks", "Smoke"),
		("MagicParticle.sks", "Magic"),
		("FirefliesParticle.sks", "Fireflies"),
		("FireParticle.sks", "Fire"),
		("BokehParticle.sks", "Bokeh")
	]
	var sampleEmitter: SKEmitterNode?
	var sampleLabel: SKLabelNode?
	var sampleIndex: Int = 0
	
	override func didMoveToView(view: SKView) {
		let labelNode = SKLabelNode()
		labelNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:20)
		labelNode.fontName = "HelveticaNeue-Light"
		self.addChild(labelNode)
		sampleLabel = labelNode
		self.backgroundColor = SKColor.darkGrayColor()
		self.showNextSampleEmitter()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		showNextSampleEmitter()
	}

	func showNextSampleEmitter() {
		print("index", sampleIndex)
		let nodeLabelTuple = emitterTuples[sampleIndex]
		if ++sampleIndex == emitterTuples.count {
			sampleIndex = 0
		}
		if sampleEmitter != nil {
			sampleEmitter!.removeFromParent()
		}
		if sampleLabel != nil {
			sampleLabel!.text = nodeLabelTuple.1
		}
		print (nodeLabelTuple)
		let nodeName = nodeLabelTuple.0
		// Tried reusing the node, but when it's re-added to scene it doesn't animate.
		let node = SKEmitterNode(fileNamed: nodeName)!
		node.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
		self.addChild(node)
		sampleEmitter = node
	}
	
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
