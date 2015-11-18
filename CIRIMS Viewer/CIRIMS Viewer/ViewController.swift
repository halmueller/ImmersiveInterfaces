//
//  ViewController.swift
//  CIRIMS Viewer
//
//  Created by Hal Mueller on 11/17/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

	@IBOutlet weak var subView: UIView!
	@IBOutlet weak var webView: WKWebView?
	override func viewDidLoad() {
		super.viewDidLoad()
		let webViewConfiguration = WKWebViewConfiguration()
		let newWebView = WKWebView(frame: self.subView.bounds, configuration: webViewConfiguration)
		newWebView.navigationDelegate = self
		newWebView.UIDelegate = self
		newWebView.allowsBackForwardNavigationGestures = true
		newWebView.backgroundColor = UIColor.greenColor()
		
		webView = newWebView
		webView?.navigationDelegate = self
		
		self.subView.addSubview(newWebView)
		newWebView.translatesAutoresizingMaskIntoConstraints = false
		let constraints = [
			NSLayoutConstraint(item: newWebView, attribute: .Leading, relatedBy: .Equal, toItem: subView, attribute: .Leading, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: newWebView, attribute: .Trailing, relatedBy: .Equal, toItem: subView, attribute: .Trailing, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: newWebView, attribute: .Top, relatedBy: .Equal, toItem: subView, attribute: .Top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: newWebView, attribute: .Bottom, relatedBy: .Equal, toItem: subView, attribute: .Bottom, multiplier: 1.0, constant: 0.0),
		]
		NSLayoutConstraint.activateConstraints(constraints)
		
		newWebView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.apple.com")!))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

