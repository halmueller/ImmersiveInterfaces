//
//  ViewController.swift
//  Spirals
//
//  Created by Hal Mueller on 10/26/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
	
	@IBOutlet weak var spriteKitView: SKView!
	
    @IBAction func openConfigurationEditor(sender: AnyObject) {
    }
	override func viewDidLoad() {
		super.viewDidLoad()
		let illusionScene = SpiralIllusionScene(size: spriteKitView.bounds.size)
		spriteKitView.showsFPS = false
		spriteKitView.presentScene(illusionScene)
		spriteKitView.backgroundColor = illusionScene.backgroundColor
		view.backgroundColor = illusionScene.backgroundColor
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

