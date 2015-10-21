//
//  ViewController.swift
//  Plummet
//
//  Created by CP120 on 10/16/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    var plummetScene: PlummetScene!
    
    @IBOutlet weak var plummetView: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
        plummetScene = PlummetScene(size: plummetView.bounds.size)
        plummetScene.backgroundColor = SKColor.blueColor()
        
        plummetView.showsFPS = true
        plummetView.showsDrawCount = true
        plummetView.showsNodeCount = true
        
        plummetView.presentScene(plummetScene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

