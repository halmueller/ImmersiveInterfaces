//: ## Constraints
//: [TOC](TOC) - [Previous](@previous) - [Next](@next)

import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 1038))
let scene = SKScene(size: CGSize(width: 425.0, height: 400.0))
scene.backgroundColor = SKColor.blueColor()

scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

let redSquare = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 15.0, height: 15.0))
let home = CGPoint(x: 100, y: 10)
redSquare.position = home

let magentaRectangle = SKSpriteNode(color: SKColor.magentaColor(), size: CGSize(width: 25.0, height: 5.0))
magentaRectangle.position = CGPoint(x: 135, y: 200)
let followConstraint = SKConstraint.distance(SKRange.init(lowerLimit: 30.0, upperLimit: 100.0), toNode:redSquare)
magentaRectangle.constraints = [followConstraint]

let greenRectangle = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 5.0, height: 25.0))
greenRectangle.position = CGPoint(x: 300, y: 100)
let aimConstraint = SKConstraint.orientToNode(redSquare, offset: SKRange.init(value: 0.0, variance: 0.0))
greenRectangle.constraints = [aimConstraint]

let yellowRectangle = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: 25.0, height: 5.0))
yellowRectangle.position = CGPoint(x: 300, y: 35)
yellowRectangle.constraints = [aimConstraint]

scene.addChild(redSquare)
scene.addChild(magentaRectangle)
scene.addChild(greenRectangle)
scene.addChild(yellowRectangle)

let moveUp = SKAction.moveByX(50.0, y: 400.0, duration: 10)
let pause = SKAction.waitForDuration(5)
let moveDown = SKAction.moveByX(0.0, y: -400.0, duration: 10)
let moveRight = SKAction.moveByX(200.0, y: 0.0, duration: 3)
let goHome = SKAction.moveTo(home, duration: 5)

redSquare.runAction(SKAction.sequence([pause, moveUp, pause, moveDown, moveRight, moveUp, goHome]))
//: [Next](@next)
