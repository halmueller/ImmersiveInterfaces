//
//  BlockScene.swift
//  Alphabet Block
//
//  Created by Hal Mueller on 11/20/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SceneKit

class BlockScene: SCNScene {
    
    override init() {
        super.init()
        
        let block = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let blockNode = SCNNode(geometry: block)
        self.rootNode.addChildNode(blockNode)
        
        block.materials = colorMaterials()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colorMaterials() -> [SCNMaterial] {
        #if os(OSX)
            let colors = [
                NSColor.whiteColor(),
                NSColor.greenColor(),
                NSColor.orangeColor(),
                NSColor.purpleColor(),
                NSColor.yellowColor(),
                NSColor.blueColor()]
            
            let letters = [
                // e, c, x, z, X, B
                NSImage(named: "e"),
                NSImage(named: "c"),
                NSImage(named: "x"),
                NSImage(named: "z"),
                NSImage(named: "X cap"),
                NSImage(named: "B cap")]
        #else
            let colors = UIColor.redColor()
        #endif
        return letters.map({
            let material = SCNMaterial()
            material.diffuse.contents = $0
            return material
        })
    }
    
}
