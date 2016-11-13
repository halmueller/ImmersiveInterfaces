//
//  ViewController.swift
//  SceneKit Shapes
//
//  Created by Hal Mueller on 11/29/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import Cocoa
import SceneKit

class ViewController: NSViewController {

	@IBOutlet weak var leftView: SCNView!
	@IBOutlet weak var centerView: SCNView!
	@IBOutlet weak var rightView: SCNView!
	let demoScene = DemoScene()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		for sceneView in [leftView, centerView, rightView] {
			sceneView?.scene = demoScene
			sceneView?.debugOptions = [.showWireframe, .showLightExtents, .showLightInfluences, .showBoundingBoxes]
			sceneView?.debugOptions = .showWireframe
			sceneView?.showsStatistics = true
		}
		rightView.pointOfView = demoScene.followSpotNode
		centerView.pointOfView = demoScene.overheadCameraNode
		leftView.pointOfView = demoScene.fixedCameraNode
	}

	override func mouseUp(with theEvent: NSEvent) {
		super.mouseUp(with: theEvent)
		let eventLocation = theEvent.locationInWindow
		
		let leftPoint = leftView.convert(eventLocation, from: nil)
		let centerPoint = centerView.convert(eventLocation, from: nil)
		let rightPoint = rightView.convert(eventLocation, from: nil)
		
		let hits: [SCNHitTestResult]?
		if NSPointInRect(leftPoint, leftView.bounds) {
			hits = leftView.hitTest(leftPoint, options: nil)
		}
		else if NSPointInRect(centerPoint, centerView.bounds) {
			hits = centerView.hitTest(centerPoint, options: nil)
		}
		else if NSPointInRect(rightPoint, rightView.bounds) {
			hits = rightView.hitTest(rightPoint, options: nil)
		}
		else {
			hits = nil
			print("no joy")
		}
			demoScene.handleTouchHits(hits)
	}

/*	- (void)mouseUp:(NSEvent *)theEvent
	{
	[super mouseUp:theEvent];
	
	// Get the location of the click
	NSPoint eventLocation = [theEvent locationInWindow];
	NSPoint point = [self convertPoint:eventLocation fromView:nil];
	
	// Only hit test the pieces
	NSDictionary *onlyPiecesOptions = @{SCNHitTestRootNodeKey: self.piecesNode};
	NSArray *hits = [self hitTest:point
	options:onlyPiecesOptions];
	
	// Get the closest piece
	SCNHitTestResult *hit = hits.firstObject;
	SCNNode *pieceNode = hit.node;
	
	// Add an animaion if the node isn't already animating
	if (pieceNode.animationKeys.count == 0) {
	[hit.node addAnimation:[self jumpAnimation] forKey:@"Jump"];
	}
	
	}
*/


}

