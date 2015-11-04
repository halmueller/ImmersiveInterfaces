//
//  EditorViewController.swift
//  Spiral Illusion
//
//  Created by Hal Mueller on 11/3/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {

	var inputConfiguration: SpiralIllusionDefinition?
	
	@IBAction func finishEditing(sender: AnyObject) {
		self.dismissViewControllerAnimated(true) { 			
		}
	}
}