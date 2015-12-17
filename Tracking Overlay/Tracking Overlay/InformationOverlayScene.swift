//
//  InformationOverlayScene.swift
//  Tracking Overlay
//
//  Created by Hal Mueller on 12/16/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit

public class InformationOverlayScene: SKScene {
	public var labelNode: SKLabelNode?
	public var cursorNode: SKShapeNode?
	
	override init(size: CGSize) {
		super.init(size: size)
		scaleMode = .ResizeFill
		labelNode = SKLabelNode(text: "tracking")
		labelNode?.position = CGPoint(x: 100, y: 400)
		self.addChild(labelNode!)
		cursorNode = SKShapeNode(circleOfRadius: 25.0)
		cursorNode?.strokeColor = UIColor.greenColor()
		self.addChild(cursorNode!)
	}

	required public init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

}
