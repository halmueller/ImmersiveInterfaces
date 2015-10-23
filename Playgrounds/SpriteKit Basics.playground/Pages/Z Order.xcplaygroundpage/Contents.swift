//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//: [TOC](TOC) - [Previous](@previous) - [Next](@next)
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
redSquare.position = CGPoint(x: 50, y: 50)
let greenSquare = SKSpriteNode(color: SKColor.greenColor(), size: CGSizeMake(25, 25))
greenSquare.position = CGPoint(x: 55, y: 55)
let blueSquare = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(25, 25))
blueSquare.position = CGPoint(x: 60, y: 60)

scene.addChild(redSquare)
//: swap the next two lines
scene.addChild(greenSquare)
scene.addChild(blueSquare)

print(redSquare.zPosition, greenSquare.zPosition, blueSquare.zPosition)

//: uncomment this line
// greenSquare.zPosition = -1

let cyanSquare = SKSpriteNode(color: SKColor.cyanColor(), size: CGSizeMake(25, 25))
cyanSquare.position = CGPoint(x: 150, y: 50)
let yellowSquare = SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeMake(25, 25))
yellowSquare.position = CGPoint(x: 155, y: 55)
let magentaSquare = SKSpriteNode(color: SKColor.magentaColor(), size: CGSizeMake(25, 25))
magentaSquare.position = CGPoint(x: 160, y: 60)

cyanSquare.zPosition = 42
yellowSquare.zPosition = 17
scene.addChild(cyanSquare)
scene.addChild(yellowSquare)
scene.addChild(magentaSquare)

