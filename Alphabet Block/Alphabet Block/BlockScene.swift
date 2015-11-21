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
                NSColor.blueColor(),
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
            
            var images: [NSImage] = []
            for i in 0..<letters.count {
                let finalImage = NSImage(size: letters[i]!.size)
                finalImage.lockFocus()
                colors[i].setFill()
                let rect = NSMakeRect(0, 0, finalImage.size.width, finalImage.size.height)
                NSBezierPath.fillRect(rect)
                letters[i]?.drawInRect(rect)
                finalImage.unlockFocus()
                images.append(finalImage)
            }
        #else
            let colors = [
                UIColor.whiteColor(),
                UIColor.greenColor(),
                UIColor.orangeColor(),
                UIColor.purpleColor(),
                UIColor.yellowColor(),
                UIColor.blueColor()]
            
            let letters = [
                // e, c, x, z, X, B
                UIImage(named: "e"),
                UIImage(named: "c"),
                UIImage(named: "x"),
                UIImage(named: "z"),
                UIImage(named: "X cap"),
                UIImage(named: "B cap")]
            
            var images: [UIImage] = []
            for i in 0..<letters.count {
/*                let finalImage = UIImage(
                finalImage.lockFocus()
                colors[i].setFill()
                let rect = NSMakeRect(0, 0, finalImage.size.width, finalImage.size.height)
                UIBezierPath.fillRect(rect)
                letters[i]?.drawInRect(rect)
                finalImage.unlockFocus()
*/
                images.append(letters[i]!)
            }
        #endif
        var result : [SCNMaterial] = []
        for i in 0..<letters.count {
            let material = SCNMaterial()
            material.diffuse.contents = images[i]
            result.append(material)
        }
        return result
    }
    
}
