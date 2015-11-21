//
//  ViewController.swift
//  Alphabet Block
//
//  Created by Hal Mueller on 11/20/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import Cocoa
import SceneKit

class ViewController: NSViewController {

    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView.scene = BlockScene()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

