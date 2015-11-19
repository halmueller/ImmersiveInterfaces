//: ## Materials Fun
//: [Previous](@previous) - [TOC](TOC) - [Next](@next)
import Cocoa
import Foundation
import SceneKit
import XCPlayground

//: from [http://stackoverflow.com/questions/24126669/using-scenekit-in-swift-playground](http://stackoverflow.com/questions/24126669/using-scenekit-in-swift-playground)

let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
sceneView.backgroundColor = NSColor.blackColor()

//sceneView.debugOptions = .ShowWireframe

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
var sphere = SCNSphere(radius: 1.0)
var sphereNode = SCNNode(geometry: sphere)
scene.rootNode.addChildNode(sphereNode)

// configure the geometry object
print(sphere.firstMaterial?.locksAmbientWithDiffuse)
sphere.firstMaterial?.diffuse.contents  = NSColor.greenColor()   // (or UIColor on iOS)
sphere.firstMaterial?.specular.contents = NSColor.redColor() // (or UIColor on iOS)
sphere.firstMaterial?.reflective.contents = NSColor.brownColor()
//sphere.firstMaterial?.emission.contents = NSColor.redColor()
print(sphere.materials)

// set a rotation axis (no angle) to be able to
// use a nicer keypath below and avoid needing
// to wrap it in an NSValue
//sphereNode.rotation = SCNVector4(x: 1.0, y: 0.2, z: 0.5, w: CGFloat(M_2_PI))

//: [Next](@next)
