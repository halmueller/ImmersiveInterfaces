//
//  DemoScene.swift
//  SceneKit Shapes
//
//  Created by Hal Mueller on 11/29/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SceneKit

#if os(iOS) || os(tvOS)
	private typealias MyColor = UIColor
	private typealias MyFont = UIFont
#elseif os(OSX)
	private typealias MyColor = NSColor
	private typealias MyFont = NSFont
#endif

class DemoScene: SCNScene {
	let materials: [SCNMaterial]
	let followSpotNode: SCNNode
	let overheadCameraNode: SCNNode
	let fixedCameraNode: SCNNode
	let carousel: SCNNode
	
	class func visibleCamera (fovDegrees: Double) -> SCNNode {
		let result = SCNNode()
		
		let shapeForCamera = SCNCone(topRadius: 0, bottomRadius: 0.1, height: 0.3)
		let shapeNode = SCNNode(geometry: shapeForCamera)
		result.addChildNode(shapeNode)
		// Make bottom of cone point along parent's -Z axis:
		shapeNode.rotation = SCNVector4Make(1, 0, 0, CGFloat(M_PI_2))

		let camera = SCNCamera()
		camera.xFov = fovDegrees
		camera.yFov = fovDegrees
        // MARK: Camera near/far clipping. Uncomment both of these, then keep zNear but omit zFar:
//		camera.zNear = 0.1
//		camera.zFar = 2.00
		result.camera = camera

		return result
	}
	
	override init() {
		let objectSize = CGFloat(0.5)
		let carouselRadius = 5 * objectSize
		let cameraFOVDegrees = 60.0
		
		let colors = [MyColor.redColor(), MyColor.blueColor(), MyColor.greenColor(), MyColor.magentaColor(), MyColor.yellowColor(), MyColor.cyanColor()]
		var newMaterials: [SCNMaterial] = []
		for color in colors {
			let thisMaterial = SCNMaterial()
            // MARK: uncomment this to get back of SCNPlane visible:
//            thisMaterial.doubleSided = true
			thisMaterial.diffuse.contents = color
			thisMaterial.specular.contents = MyColor.whiteColor()
			newMaterials.append(thisMaterial)
		}
		materials = newMaterials
	
		overheadCameraNode = DemoScene.visibleCamera(cameraFOVDegrees)
		overheadCameraNode.position = SCNVector3Make(0, 3 * carouselRadius, 0)
		
		fixedCameraNode = DemoScene.visibleCamera(cameraFOVDegrees)
		fixedCameraNode.position = SCNVector3Make(-1 * carouselRadius, carouselRadius, carouselRadius)
		//fixedCameraNode.position = SCNVector3Make(0, 3 * carouselRadius, 0)
		
		followSpotNode = DemoScene.visibleCamera(cameraFOVDegrees)
		followSpotNode.position = SCNVector3Make(1.1*carouselRadius/sqrt(2.0), 3*objectSize, carouselRadius/sqrt(2.0))
		 let followSpotLight = SCNLight()
		followSpotLight.type = SCNLightTypeSpot
		followSpotLight.castsShadow = true
		followSpotNode.light = followSpotLight
		
		carousel = SCNNode()
		super.init()
		
		let ambientLight = SCNLight()
		ambientLight.type = SCNLightTypeAmbient
		let ambientLightNode = SCNNode()
		ambientLightNode.light = ambientLight
		self.rootNode.addChildNode(ambientLightNode)

		self.rootNode.addChildNode(followSpotNode)
		self.rootNode.addChildNode(overheadCameraNode)
		self.rootNode.addChildNode(fixedCameraNode)
		
		carousel.position = SCNVector3Make(0, objectSize, 0)
		let rotate = SCNAction.repeatActionForever(SCNAction.rotateByX(0.0, y: CGFloat(M_PI), z: 0, duration: 20.0))
		carousel.runAction(rotate)
		self.rootNode.addChildNode(carousel)

		let carouselConstraint = SCNLookAtConstraint(target: carousel)
        // MARK: uncomment this to correct horizon:
		//carouselConstraint.gimbalLockEnabled = true
		overheadCameraNode.constraints = [carouselConstraint]
		fixedCameraNode.constraints = [carouselConstraint]
		
		let centerMarkerGeometry = SCNSphere(radius: objectSize/4)
		centerMarkerGeometry.firstMaterial = materials[1]
		let centerNode = SCNNode(geometry: centerMarkerGeometry)
		self.rootNode.addChildNode(centerNode)

		let capsule = SCNCapsule(capRadius: objectSize/4, height: objectSize)
	
		let standardSphere = SCNSphere(radius: objectSize/2)
		standardSphere.geodesic = false
		
		let tube = SCNTube(innerRadius: 0.4 * objectSize, outerRadius: 0.5 * objectSize, height: objectSize)
		
		let geodesicSphere = SCNSphere(radius: objectSize/2)
		geodesicSphere.geodesic = true
		
		let pyramid = SCNPyramid(width: objectSize/3, height: objectSize, length: objectSize/5)
		
		let pyramid2 = SCNPyramid(width: objectSize/2, height: objectSize, length: objectSize/2)
		
		let plane = SCNPlane(width: objectSize, height: objectSize)
		
		let cone1 = SCNCone(topRadius: 0, bottomRadius: objectSize/4, height: objectSize)

		let cone2 = SCNCone(topRadius: objectSize/6, bottomRadius: objectSize/3, height: objectSize)
		
		let sourceString = NSAttributedString(string: "hello", attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
		 NSFontAttributeName: MyFont(name: "Chalkduster", size: 0.5)!])
		let text = SCNText(string: sourceString, extrusionDepth: objectSize/10)
		
		let torus = SCNTorus(ringRadius: objectSize, pipeRadius: objectSize/8)
		
		let cylinder = SCNCylinder(radius: objectSize/4, height: objectSize)

		let chamferedBox = SCNBox(width: objectSize, height: objectSize, length: objectSize/2, chamferRadius: 0.2)
		
		let box = SCNBox(width: objectSize/2, height: objectSize, length: objectSize, chamferRadius: 0)
		
		let geometries = [capsule, standardSphere, tube, geodesicSphere, pyramid, pyramid2, text, plane, cone1, cone2, torus, cylinder, box, chamferedBox]
		var index = 0
		let angleIncrement = 2.0 * M_PI/Double(geometries.count)
		var lastNode: SCNNode!
		for geometry in geometries {
			geometry.materials = materials
			let node = SCNNode(geometry: geometry)
			let angle = CGFloat(angleIncrement * Double(index++))
			let x = carouselRadius * cos(angle)
			let y = carouselRadius * sin(angle)
			node.position = SCNVector3Make(x, 0, y)
            // MARK: uncomment this to get nodes parallel to radius:
//			node.eulerAngles.y = -1.0 * angle
			carousel.addChildNode(node)
			lastNode = node
		}
		self.trackWithSpotlight(lastNode)
		
		let floor = SCNFloor()
		self.rootNode.addChildNode(SCNNode(geometry: floor))
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	func handleTouchHits(hits: [SCNHitTestResult]?) {
		if hits != nil {
			for hit in hits! {
				if hit.node.parentNode == self.carousel {
					debugPrint (hit.node)
					self.trackWithSpotlight(hit.node)
					let animationAction = SCNAction.moveByX(0, y: 1, z: 0, duration: 5)
					let fadeAction = SCNAction.fadeOpacityTo(0.0, duration: 5)
					let unfadeAction = SCNAction.fadeOpacityTo(1.0, duration: 5)
					let growAction = SCNAction.scaleBy(2.0, duration: 5)
					let sequence = SCNAction.sequence([animationAction, animationAction.reversedAction(),
						fadeAction, unfadeAction,
						growAction, growAction.reversedAction()])
					hit.node.runAction(sequence)
				}
			}
		}
	}

	func trackWithSpotlight (target: SCNNode) {
		let followSpotConstraint = SCNLookAtConstraint(target: target)
        // MARK: uncomment this to correct horizon:
		//followSpotConstraint.gimbalLockEnabled = true
		followSpotNode.constraints = [followSpotConstraint]
		
	}
}
