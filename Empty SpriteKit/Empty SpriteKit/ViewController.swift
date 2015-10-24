//
//  ViewController.swift
//  Empty SpriteKit
//
//  Created by Hal Mueller on 10/23/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet weak var spriteKitView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spriteKitScene = SpriteKitScene(size: spriteKitView.bounds.size)
        spriteKitScene.backgroundColor = SKColor.blueColor()
        spriteKitView.showsFPS = true
        spriteKitView.presentScene(spriteKitScene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

