//
//  GameViewController.swift
//  Nested Scenes
//
//  Created by Hal Mueller on 1/5/16.
//  Copyright (c) 2016 Hal Mueller. All rights reserved.
//

import SceneKit
import SpriteKit
import QuartzCore

class GameViewController: NSViewController {
	
	@IBOutlet weak var gameView: GameView!
	
	override func awakeFromNib(){
		// create a new scene
		let scene = SCNScene()
		
		// create and add a camera to the scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		scene.rootNode.addChildNode(cameraNode)
		
		// place the camera
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 7)
		
		// create and add a light to the scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light!.type = SCNLightTypeOmni
		lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = NSColor.darkGrayColor()
		scene.rootNode.addChildNode(ambientLightNode)
		
		let cubeNode1 = self.coloredBlockNode()
		let cubeNode2 = cubeNode1.clone()

		scene.rootNode.addChildNode(cubeNode1)
		cubeNode1.rotation = SCNVector4(x: 1.0, y: 1.0, z: 0.0, w: 0.0)
		cubeNode1.position = SCNVector3(x: -2, y: 0, z: 0)
		
		scene.rootNode.addChildNode(cubeNode2)
		cubeNode2.rotation = SCNVector4(x: 0.5, y: 1.0, z: 1.0, w: 0.0)
		cubeNode2.position = SCNVector3(x: 2, y: 0, z: 0)
		
		// animate the rotation of the torus
		let spin = CABasicAnimation(keyPath: "rotation.w") // only animate the angle
		spin.toValue = 2.0*M_PI
		spin.duration = 15
		spin.repeatCount = HUGE // for infinity
		cubeNode1.addAnimation(spin, forKey: "spin around")
		cubeNode2.addAnimation(spin, forKey: "spin around too")
		
		// set the scene to the view
		self.gameView!.scene = scene
		
		// show statistics such as fps and timing information
		self.gameView!.showsStatistics = true
		
		// configure the view
		self.gameView!.backgroundColor = NSColor.blackColor()
	}
	
	func coloredBlockNode() -> SCNNode {
		
		let block = SCNBox(width: 2, height: 2, length: 2, chamferRadius: 0)
		let result = SCNNode(geometry: block)
		
		// Use array of colors for 6 different colors. Or just set firstMaterial for 6 animations.
		block.materials = colorMaterials()
		for i in [0, 1, 4] {
			// instantiate the embedded scene multiple times, to test render sync
			let sceneKitMaterial = SCNMaterial()
			sceneKitMaterial.diffuse.contents = self.spinningShipSpriteKitScene()
			block.materials[i] = sceneKitMaterial
		}
		return result
	}
	
	func colorMaterials() -> [SCNMaterial] {
		let colors = [
			SKColor.blueColor(),
			SKColor.greenColor(),
			SKColor.orangeColor(),
			SKColor.purpleColor(),
			SKColor.yellowColor(),
			SKColor.cyanColor()]
		
		var result : [SCNMaterial] = []
		for i in 0 ..< colors.count {
			let material = SCNMaterial()
			material.diffuse.contents = colors[i]
			result.append(material)
		}
		return result
	}
	
	func spinningShipSpriteKitScene() -> SKScene {
		let resultSize = CGSize(width: 200, height: 200)
		let result = SKScene(size: resultSize)
		result.scaleMode = .ResizeFill
		let spinningShipNode = SK3DNode(viewportSize: result.size)
		
		let spinningShipScene = self.spinningShipScene()
		spinningShipScene.rootNode.scale = SCNVector3Make(1, -10, 1)
		spinningShipNode.scnScene = spinningShipScene
		result.addChild(spinningShipNode)
		spinningShipNode.position = CGPoint(x: resultSize.width/2.0, y: resultSize.height/2.0)
		return result
	}
	
	func spinningShipScene() -> SCNScene {
		let scene = SCNScene(named: "art.scnassets/ship.scn")!
		
		// create and add a camera to the scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		scene.rootNode.addChildNode(cameraNode)
		
		// place the camera
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
		// TODO: Figure out a better way to flip the camera
		cameraNode.rotation = SCNVector4Make(0.0, 0.0, 1.0, CGFloat(M_PI));
		
		// create and add a light to the scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light!.type = SCNLightTypeOmni
		lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = SKColor.darkGrayColor()
		scene.rootNode.addChildNode(ambientLightNode)
		
		// retrieve the ship node
		let ship = scene.rootNode.childNodeWithName("ship", recursively: true)!
		
		// animate the 3d object
		ship.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
		return scene
	}
	
}
