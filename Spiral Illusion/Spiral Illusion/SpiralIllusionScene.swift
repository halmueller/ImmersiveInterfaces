//
//  SpiralIllusionScene.swift
//  Spiral Illusion
//
//  Created by Hal Mueller on 10/23/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit

class SpiralIllusionScene: SKScene {
    let definition: SpiralIllusionDefinition!
    
    override init(size: CGSize) {
        definition = SpiralIllusionDefinition()
        super.init(size: size)
        
        let labelNode = SKLabelNode(text: String(definition.numberOfRings))
        labelNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(labelNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}