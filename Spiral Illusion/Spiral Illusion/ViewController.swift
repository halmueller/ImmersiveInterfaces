//
//  ViewController.swift
//  Spiral Illusion
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
        let illusionScene = SpiralIllusionScene(size: spriteKitView.bounds.size)
        spriteKitView.showsFPS = false
        spriteKitView.presentScene(illusionScene)
		spriteKitView.backgroundColor = illusionScene.backgroundColor
		view.backgroundColor = illusionScene.backgroundColor
	}

    @IBAction func triggerConfigEditor(sender: AnyObject) {
        self.performSegueWithIdentifier("editTheThing", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "editTheThing" {
			let destVC = segue.destinationViewController as! EditorViewController
			destVC.inputConfiguration = nil
		}
	}
}

