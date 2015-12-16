//
//  GameViewController.swift
//  Tracking Overlay
//
//  Created by Hal Mueller on 12/8/15.
//  Copyright (c) 2015 Hal Mueller. All rights reserved.
//

import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = OrbitalScene()          
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        scnView.pointOfView = scene.fixedCameraNode
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
//        scnView.showsStatistics = true
		scnView.debugOptions = [SCNDebugOptions.ShowWireframe]
        
        // configure the view
        scnView.backgroundColor = UIColor.yellowColor()
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
