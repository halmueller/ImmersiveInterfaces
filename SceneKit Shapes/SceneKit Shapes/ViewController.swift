//
//  ViewController.swift
//  SceneKit Shapes
//
//  Created by Hal Mueller on 11/29/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import Cocoa
import SceneKit

class ViewController: NSViewController {

	@IBOutlet weak var leftView: SCNView!
	@IBOutlet weak var centerView: SCNView!
	@IBOutlet weak var rightView: SCNView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let demoScene = DemoScene()
		for sceneView in [leftView, centerView, rightView] {
			sceneView.scene = demoScene
			sceneView.debugOptions = [.ShowWireframe, .ShowLightExtents, .ShowLightInfluences, .ShowBoundingBoxes]
			sceneView.debugOptions = .ShowWireframe
			sceneView.showsStatistics = true
		}
		rightView.pointOfView = demoScene.followSpotNode
		centerView.pointOfView = demoScene.overheadCameraNode
		leftView.pointOfView = demoScene.fixedCameraNode
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

