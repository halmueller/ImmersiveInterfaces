//: ## Cube
//: [Previous](@previous) - [TOC](TOC) - [Next](@next)
import Cocoa
import Foundation
import SceneKit
import XCPlayground

//: from [http://stackoverflow.com/questions/24126669/using-scenekit-in-swift-playground](http://stackoverflow.com/questions/24126669/using-scenekit-in-swift-playground)

let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
sceneView.backgroundColor = NSColor.blackColor()

sceneView.debugOptions = .ShowPhysicsFields

XCPlaygroundPage.currentPage.liveView = sceneView

var scene = SCNScene()
sceneView.scene = scene

// default lighting
sceneView.autoenablesDefaultLighting = true

// a camera
var cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.position = SCNVector3(x: 0, y: 0, z: 3)
scene.rootNode.addChildNode(cameraNode)

// a geometry object
var cube = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1)
var cubeNode = SCNNode(geometry: cube)
scene.rootNode.addChildNode(cubeNode)

// configure the geometry object
cube.firstMaterial?.diffuse.contents  = NSColor.greenColor()   // (or UIColor on iOS)
cube.firstMaterial?.specular.contents = NSColor.redColor() // (or UIColor on iOS)

// set a rotation axis (no angle) to be able to
// use a nicer keypath below and avoid needing
// to wrap it in an NSValue
cubeNode.rotation = SCNVector4(x: 1.0, y: 1.0, z: 0.0, w: 0.0)

// animate the rotation of the torus
var spin = CABasicAnimation(keyPath: "rotation.w") // only animate the angle
spin.toValue = 2.0*M_PI
spin.duration = 12
spin.repeatCount = HUGE // for infinity
cubeNode.addAnimation(spin, forKey: "spin around")

//: [Next](@next)
