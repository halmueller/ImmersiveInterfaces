//
//  ViewController.swift
//  Marble Trails
//
//  Created by Hal Mueller on 11/2/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {

    class func unarchiveFromFile<SceneSubclass:SKScene>(file : String) -> SceneSubclass? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)

            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SceneSubclass
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var skView: SKView!

    let sceneNames = ["Intro", "MarblesScene", "BlocksSceneOne", "BlocksSceneTwo", "MarblesSceneTwo"]
    var sceneIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsDrawCount = true
        if let scene = MarblesScene.unarchiveFromFile(sceneNames[sceneIndex++]) as? MarblesScene {
            scene.scaleMode = .AspectFit
            skView.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeScene(sender: AnyObject) {
        let sceneName = sceneNames[sceneIndex]

        if ++sceneIndex == sceneNames.count {
            sceneIndex = 0
        }

        if let scene = MarblesScene.unarchiveFromFile(sceneName) as? MarblesScene {
            scene.scaleMode = .AspectFit
            skView.presentScene(scene)
        }
    }
    
    @IBAction func toggleTrails(sender: AnyObject) {
        if let scene = skView.scene as? MarblesScene {
            scene.showTrails = !scene.showTrails
        }
    }
}

