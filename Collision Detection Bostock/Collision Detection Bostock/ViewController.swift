//
//  ViewController.swift
//  Collision Detection Bostock
//
//  Created by Hal Mueller on 11/2/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

	@IBOutlet weak var skView: SKView!
	override func viewDidLoad() {
		super.viewDidLoad()
		let collisionDetectionScene = CollisionDetectionScene(size: self.view.bounds.size)
		skView.showsFPS = true
		skView.presentScene(collisionDetectionScene)

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

