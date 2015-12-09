//
//  GameViewController.swift
//  Gimbal Lock
//
//  Created by Hal Mueller on 12/3/15.
//  Copyright (c) 2015 Hal Mueller. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    var ship: SCNNode?
    
    @IBOutlet weak var gameView: SCNView!
    
    @IBOutlet weak var pitchField: NSTextField!
    @IBOutlet weak var yawField: NSTextField!
    @IBOutlet weak var rollField: NSTextField!
    
    
    @IBAction func pitchChanged(sender: AnyObject) {
        if let newPitchDegrees = pitchField?.doubleValue  {
            ship!.eulerAngles.x = CGFloat(newPitchDegrees * M_PI / 180)
        }
        print (ship!.eulerAngles)
    }

    @IBAction func yawChanged(sender: AnyObject) {
        if let newYawDegrees = yawField?.doubleValue  {
            ship!.eulerAngles.y = CGFloat(newYawDegrees * M_PI / 180)
        }
        print (ship!.eulerAngles)
    }

    @IBAction func rollChanged(sender: AnyObject) {
        if let newRollDegrees = rollField?.doubleValue  {
            ship!.eulerAngles.z = CGFloat(newRollDegrees * M_PI / 180)
        }
        print (ship!.eulerAngles)
    }

    override func awakeFromNib(){
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 1, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = NSColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        ship = scene.rootNode.childNodeWithName("ship", recursively: true)!

        // set the scene to the view
        self.gameView!.scene = scene
        
        // don't allow the user to manipulate the camera
        self.gameView!.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = NSColor.blackColor()
        
        pitchField.doubleValue = Double(ship!.eulerAngles.x) * 180/M_PI
        yawField.doubleValue = Double(ship!.eulerAngles.y) * 180/M_PI
        rollField.doubleValue = Double(ship!.eulerAngles.z) * 180/M_PI
    }

}
