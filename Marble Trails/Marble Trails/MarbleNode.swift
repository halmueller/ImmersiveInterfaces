//
//  MarbleNode.swift
//  Marble Trails
//
//  Created by Hal Mueller on 11/6/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SpriteKit

enum marbleNodeNames: String {
    case marble = "Marble"
    case trail = "MarbleTrail"
}

class MarbleNode: SKNode {
    static let trailsBirthRate = CGFloat(100.0)
    private let emitter: SKEmitterNode
    
    convenience override init () {
        self.init(showTrail: true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func adjustParticleBirthRate () {
        if (showTrail) {
            emitter.particleBirthRate = MarbleNode.trailsBirthRate
        }
        else {
            emitter.particleBirthRate = 0
        }
    }

    var showTrail: Bool = true {
        didSet {
            adjustParticleBirthRate()
       }
    }
    required init (showTrail: Bool) {
        let marbleSprite = SKShapeNode(circleOfRadius: 10.0)
        marbleSprite.physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        marbleSprite.physicsBody?.affectedByGravity = true
        marbleSprite.physicsBody?.dynamic = true
        marbleSprite.fillColor = SKColor.yellowColor()
        
        emitter = SKEmitterNode()
        emitter.name = marbleNodeNames.trail.rawValue
        emitter.particleTexture = SKTexture(imageNamed: "spark")
        emitter.particleAlphaSpeed = -1.0
        emitter.particleLifetime = 2
        emitter.particleScale = 0.2
        marbleSprite.addChild(emitter)
        
        super.init()
        self.addChild(marbleSprite)
        emitter.targetNode = self
        self.showTrail = showTrail
        adjustParticleBirthRate()
        self.name = marbleNodeNames.marble.rawValue
    }
}
