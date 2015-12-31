//
//  ViewController.swift
//  Flight Path
//
//  Created by Hal Mueller on 12/27/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import SceneKit

#if os(iOS) || os(tvOS)
	typealias FPViewController = UIViewController
#elseif os(OSX)
	typealias FPViewController = NSViewController
#endif


class ViewController: FPViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

}

