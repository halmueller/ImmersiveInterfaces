//
//  ViewController.swift
//  D3Plus Sampler
//
//  Created by Hal Mueller on 11/24/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
	
	@IBOutlet weak var subView: UIView!
	@IBOutlet weak var webView: WKWebView?
	
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var hitherButton: UIButton!
	@IBOutlet weak var yonButton: UIButton!
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
		self.loadTheStuff(self)
	}
	
	@IBAction func loadTheStuff(sender: AnyObject) {
		loadAndViewConcussionData()
	}
	
	func loadAndViewConcussionData() {
		// build the data as a native Swift object, as if we're plotting data generated in the Swift app
		let concussionData = [["year": 2001, "name":"concussions", "value": 0],
			["year": 2002, "name":"concussions", "value": 1],
			["year": 2003, "name":"concussions", "value": 3],
			["year": 2004, "name":"concussions", "value": 0],
			["year": 2005, "name":"concussions", "value": 4],
			["year": 2006, "name":"concussions", "value": 2],
			["year": 2007, "name":"concussions", "value": 4],
			["year": 2008, "name":"concussions", "value": 3],
			["year": 2009, "name":"concussions", "value": 6],
			["year": 2010, "name":"concussions", "value": 10],
			["year": 2011, "name":"concussions", "value": 14],
			["year": 2012, "name":"concussions", "value": 14],
			["year": 2013, "name":"concussions", "value": 19],
			["year": 2014, "name":"concussions", "value": 22]]
		
		let valuesAsJSONData = try! NSJSONSerialization.dataWithJSONObject(concussionData, options: NSJSONWritingOptions(rawValue: 0))
		let valuesAsJSONString = NSString(data: valuesAsJSONData, encoding: NSUTF8StringEncoding)! as String
		let fullJavaScriptCall = "var sample_data = \(valuesAsJSONString)"
		debugPrint (fullJavaScriptCall)
		
		let userScript = WKUserScript(source: fullJavaScriptCall, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
		webView?.configuration.userContentController.addUserScript(userScript)
		let localPath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
		webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
			// FIXME: what does this parameter mean? Must be a fileURL (undocumented)
			allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	// MARK: - WKNavigationDelegate
	func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		print ("loading", webView.URL?.path)
	}
	
	func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
		withError error: NSError) {
			print("didFailProvisionalNavigation", navigation, error.localizedDescription, error.localizedFailureReason)
			let alertController = UIAlertController(title:"Load failed", message: error.localizedDescription, preferredStyle: .Alert)
			alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
			self.presentViewController(alertController, animated: true) { }
	}
	
	// MARK: - WKUIDelegate
	func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
		fatalError("not yet implemented")
	}


}

