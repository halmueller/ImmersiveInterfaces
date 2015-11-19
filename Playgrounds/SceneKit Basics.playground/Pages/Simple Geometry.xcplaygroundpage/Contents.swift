//: ## Hello World
//: [Previous](@previous) - [TOC](TOC) - [Next](@next)
import Cocoa
import Foundation
import SceneKit
import XCPlayground

//: from [http://stackoverflow.com/questions/24126669/using-scenekit-in-swift-playground](http://stackoverflow.com/questions/24126669/using-scenekit-in-swift-playground)

let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))

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
var torus = SCNTorus(ringRadius: 1, pipeRadius: 0.35)
var torusNode = SCNNode(geometry: torus)
scene.rootNode.addChildNode(torusNode)

// configure the geometry object
torus.firstMaterial?.diffuse.contents  = NSColor.redColor()   // (or UIColor on iOS)
torus.firstMaterial?.specular.contents = NSColor.whiteColor() // (or UIColor on iOS)

// set a rotation axis (no angle) to be able to
// use a nicer keypath below and avoid needing
// to wrap it in an NSValue
torusNode.rotation = SCNVector4(x: 1.0, y: 1.0, z: 0.0, w: 0.0)

// animate the rotation of the torus
var spin = CABasicAnimation(keyPath: "rotation.w") // only animate the angle
spin.toValue = 2.0*M_PI
spin.duration = 3
spin.repeatCount = HUGE // for infinity
torusNode.addAnimation(spin, forKey: "spin around")

//: [Next](@next)
