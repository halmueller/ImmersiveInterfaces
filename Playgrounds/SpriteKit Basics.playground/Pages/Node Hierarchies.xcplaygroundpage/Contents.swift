//: ## Node Hierarchies
//: [TOC](TOC) - [Previous](@previous) - [Next](@next)

import Foundation
import SpriteKit
import XCPlayground

//: #### Basic SpriteKit setup for playgrounds:
let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 600))
let scene = SKScene(size: CGSize(width: 425.0, height: 300.0))
scene.backgroundColor = SKColor.whiteColor()

scene.scaleMode = .AspectFit
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

let redSquare = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(25, 25))
redSquare.position = CGPoint(x: 0, y: 00)
let greenSquare = SKSpriteNode(color: SKColor.greenColor(), size: CGSizeMake(25, 25))
greenSquare.position = CGPoint(x: 50, y: 25)
let blueSquare = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(25, 25))
blueSquare.position = CGPoint(x: -50, y: 75)

let rotateHalfway = SKAction.rotateByAngle(CGFloat(M_PI), duration: 5)
greenSquare.runAction(rotateHalfway)

let simpleNode = SKNode()
simpleNode.position = CGPoint(x: 200, y: 200)
scene.addChild(simpleNode)
simpleNode.addChild(redSquare)
simpleNode.addChild(greenSquare)
simpleNode.addChild(blueSquare)

let moveToLowerLeft = SKAction.moveTo(CGPoint(x: 50, y: 50), duration: 10)
let moveToUpperLeft = SKAction.moveTo(CGPoint(x: 50, y: 250), duration: 10)

simpleNode.runAction(SKAction.sequence([moveToLowerLeft, SKAction.group([moveToUpperLeft, rotateHalfway]), rotateHalfway]))
   


//: [Next](@next)
