//
//  GameViewController.swift
//  Tracking Overlay
//
//  Created by Hal Mueller on 12/8/15.
//  Copyright (c) 2015 Hal Mueller. All rights reserved.
//

import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
	@IBOutlet var sceneView: SCNView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// create a new scene
		let scene = OrbitalScene()
		sceneView.pointOfView = scene.fixedCameraNode
		sceneView.scene = scene
		sceneView.allowsCameraControl = true
		sceneView.showsStatistics = true
		//		sceneView.debugOptions = [SCNDebugOptions.ShowWireframe]
		sceneView.backgroundColor = UIColor.grayColor()
		
		sceneView.delegate = self
		
		sceneView.overlaySKScene = InformationOverlayScene(size: sceneView.frame.size)
		print(sceneView.overlaySKScene)
	}
	
	override func shouldAutorotate() -> Bool {
		return true
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	// MARK: SCNSceneRendererDelegate -
	
	func renderer(renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: NSTimeInterval)  {
		if let overlay = sceneView.overlaySKScene as? InformationOverlayScene {
			if let orbitalScene = sceneView.scene as? OrbitalScene {
//				print ("box raw", orbitalScene.boxNode.position)
//				print ("box presentation node", orbitalScene.boxNode.presentationNode.position)
//				let boxWorldCoordinates = orbitalScene.rootNode.convertPosition(orbitalScene.boxNode.position, fromNode: orbitalScene.carouselNode)
				let boxWorldCoordinates = orbitalScene.rootNode.convertPosition(orbitalScene.boxNode.position, fromNode:orbitalScene.boxNode.parentNode)
				
//				print("box world", boxWorldCoordinates)
				let screenCoordinates = self.sceneView.projectPoint(boxWorldCoordinates)
				print ("screen", screenCoordinates)
				overlay.labelNode?.text = String(format: "%03.1f, %03.1f, %03.1f",
					boxWorldCoordinates.x, boxWorldCoordinates.y, boxWorldCoordinates.z)
				print(overlay.size.height)
				let boxY = overlay.size.height - CGFloat(screenCoordinates.y)
				overlay.cursorNode?.position.x = CGFloat(screenCoordinates.x)
				overlay.cursorNode?.position.y = boxY
				overlay.labelNode?.position.x = CGFloat(screenCoordinates.x)
				overlay.labelNode?.position.y = boxY + 50
			}
		}
	}
}
