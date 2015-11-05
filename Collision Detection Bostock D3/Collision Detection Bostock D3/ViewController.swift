//
//  ViewController.swift
//  Collision Detection Bostock D3
//
//  Created by Hal Mueller on 11/3/15.
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

		webView = newWebView
		webView?.backgroundColor = UIColor.greenColor()
		webView?.navigationDelegate = self
		print(webView)
		self.subView.addSubview(newWebView)
		print (subView.frame, subView.bounds)
		print (newWebView.frame, newWebView.bounds)
//		print (sampleRequest)

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/// MARK: -
	func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		print (webView.URL?.path)
	}
	
	@IBAction func loadLocalHelloWorld(sender: AnyObject) {
		let localPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
		print ("local path", localPath)
		webView?.loadFileURL(NSURL(fileURLWithPath: localPath!), allowingReadAccessToURL: NSURL(fileURLWithPath: "/abc"))
	}

	@IBAction func loadCNNUnsecure(sender: AnyObject) {
		let sampleURL = NSURL(string: "http://www.cnn.com")
		let sampleRequest = NSURLRequest(URL: sampleURL!)
		webView?.loadRequest(sampleRequest)
	}
	
	@IBAction func loadCNNSecure(sender: AnyObject) {
		let sampleURL = NSURL(string: "https://www.cnn.com")
		let sampleRequest = NSURLRequest(URL: sampleURL!)
		webView?.loadRequest(sampleRequest)
	}
	
	@IBAction func loadApple(sender: AnyObject) {
		let sampleURL = NSURL(string: "https://www.apple.com")
		let sampleRequest = NSURLRequest(URL: sampleURL!)
		webView?.loadRequest(sampleRequest)
	}
	@IBAction func loadLocalCollisionDetection(sender: AnyObject) {
		// http://bl.ocks.org/mbostock/3231298
		let localPath = NSBundle.mainBundle().pathForResource("collisionDetection", ofType: "html")
		print ("local path", localPath)
		webView?.loadFileURL(NSURL(fileURLWithPath: localPath!), allowingReadAccessToURL: NSURL(fileURLWithPath: "/abc"))
	}

	@IBAction func loadOtherD3(sender: AnyObject) {
	}
	func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
		withError error: NSError) {
		print(navigation, error.localizedDescription, error.localizedFailureReason)
			let alertController = UIAlertController(title:"Load failed", message: error.localizedDescription, preferredStyle: .Alert)
			alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
			self.presentViewController(alertController, animated: true) { }
	}
	
}

