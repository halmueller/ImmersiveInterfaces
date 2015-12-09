//
//  OrbitalScene.swift
//  Tracking Overlay
//
//  Created by Hal Mueller on 12/8/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

#if os(iOS) || os(tvOS)
    private typealias MyColor = UIColor
    private typealias MyFont = UIFont
#elseif os(OSX)
    private typealias MyColor = NSColor
    private typealias MyFont = NSFont
#endif

import SceneKit

class OrbitalScene: SCNScene {
    
    let fixedCameraNode: SCNNode
    let carouselNode: SCNNode
    
    class func visibleCamera (fovDegrees: Double) -> SCNNode {
        let result = SCNNode()
        
        let shapeForCamera = SCNCone(topRadius: 0, bottomRadius: 0.1, height: 0.3)
        let shapeNode = SCNNode(geometry: shapeForCamera)
        result.addChildNode(shapeNode)
        // Make bottom of cone point along parent's -Z axis:
        shapeNode.rotation = SCNVector4Make(1, 0, 0, Float(M_PI_2))
        
        let camera = SCNCamera()
//        camera.usesOrthographicProjection = true
        camera.xFov = fovDegrees
        camera.yFov = fovDegrees
        // MARK: Camera near/far clipping. Uncomment both of these, then keep zNear but omit zFar:
        //		camera.zNear = 0.1
        //		camera.zFar = 2.00
        result.camera = camera
        
        return result
    }
    
    override init() {
        let objectSize = Float(0.5)
        let orbitRadius = 30 * objectSize
        let cameraFOVDegrees = 70.0
        
        fixedCameraNode = OrbitalScene.visibleCamera(cameraFOVDegrees)
        fixedCameraNode.position = SCNVector3Make(-1.5 * orbitRadius, 0.5 * orbitRadius, 1.5 * orbitRadius)
        //fixedCameraNode.position = SCNVector3Make(0, 3 * carouselRadius, 0)
        
        carouselNode = SCNNode()
        super.init()

        let centerSize = CGFloat(1.0)
        let centerMarkerGeometry = SCNSphere(radius: centerSize)
        let centerNode = SCNNode(geometry: centerMarkerGeometry)
        centerMarkerGeometry.firstMaterial?.diffuse.contents = MyColor.redColor()
        
        self.rootNode.addChildNode(centerNode)
        self.rootNode.addChildNode(carouselNode)
        
        let ambientLight = SCNLight()
        ambientLight.type = SCNLightTypeAmbient
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        self.rootNode.addChildNode(ambientLightNode)
        
        self.rootNode.addChildNode(fixedCameraNode)
        
        let carouselConstraint = SCNLookAtConstraint(target: centerNode)
        // MARK: uncomment this to correct horizon:
        //carouselConstraint.gimbalLockEnabled = true
        fixedCameraNode.constraints = [carouselConstraint]

        let box = SCNBox(width: centerSize, height: centerSize, length: centerSize, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = MyColor.cyanColor()
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3Make(orbitRadius, 0, orbitRadius)
//        boxNode.position = SCNVector3Make(-5, 5, 5)
        carouselNode.addChildNode(boxNode)

        let rotate = SCNAction.repeatActionForever(SCNAction.rotateByX(0.0, y: CGFloat(M_PI), z: 0, duration: 20.0))
        carouselNode.runAction(rotate)
        self.rootNode.addChildNode(carouselNode)

        let boxNodeConstraint = SCNLookAtConstraint(target: boxNode)
//        fixedCameraNode.constraints = [boxNodeConstraint]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
