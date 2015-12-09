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

    #if os(OSX)
    typealias BLColor = NSColor
    typealias BLImage = NSImage
    #else
    typealias BLColor = UIColor
    typealias BLImage = UIImage
    #endif
    func colorMaterials() -> [SCNMaterial] {
        let colors = [
            BLColor.blueColor(),
            BLColor.greenColor(),
            BLColor.orangeColor(),
            BLColor.purpleColor(),
            BLColor.yellowColor(),
            BLColor.blueColor()]

        let letters = [
            // e, c, x, z, X, B
            BLImage(named: "e"),
            BLImage(named: "c"),
            BLImage(named: "x"),
            BLImage(named: "z"),
            BLImage(named: "X cap"),
            BLImage(named: "B cap")]

        var result : [SCNMaterial] = []
        var images: [BLImage] = []
        #if os(OSX)
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
        for i in 0..<letters.count {
            let material = SCNMaterial()
            material.diffuse.contents = images[i]
            result.append(material)
        }
        return result
    }
    
}
