//
//  ViewController.swift
//  Alphabet Block iOS
//
//  Created by Hal Mueller on 11/20/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.scene = BlockScene()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

