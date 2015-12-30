//
//  FlightPathScene.swift
//  Flight Path
//
//  Created by Hal Mueller on 12/27/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import Cocoa
import SceneKit

class FlightPathScene: SCNScene {
	var flightPath: FlightPath?
	
	override init() {
		super.init()
		flightPath = nil
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
}
