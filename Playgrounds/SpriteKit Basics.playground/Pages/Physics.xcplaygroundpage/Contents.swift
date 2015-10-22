//: [TOC](TOC) - [Previous](@previous) - [Next](@next)

import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 1038))
let scene = SKScene(size: CGSize(width: 425.0, height: 400.0))
scene.backgroundColor = SKColor.maroonColor()

scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

