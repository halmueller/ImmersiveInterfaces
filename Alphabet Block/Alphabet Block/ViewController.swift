//
//  ViewController.swift
//  Alphabet Block
//
//  Created by Hal Mueller on 11/20/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SceneKit

#if os(iOS) || os(tvOS)
    typealias ViewControllerSuper = UIViewController
#elseif os(OSX)
    typealias ViewControllerSuper = NSViewController
#endif

class ViewController: ViewControllerSuper {

    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView.scene = BlockScene()
    }

}

