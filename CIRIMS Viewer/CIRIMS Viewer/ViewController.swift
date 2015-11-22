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
	var CIRIMSString: String?
	
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
		
		loadAndViewCIRIMSFileAtURLPath("http://cirims.apl.washington.edu/DataFiles/CIRIMS04_Guam_Japan_v1.0.txt")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// CIRIMS data files: http://cirims.apl.washington.edu/DataFiles/
	func loadAndViewCIRIMSFileAtURLPath(URLString: String) {
		// load http://cirims.apl.washington.edu/DataFiles/CIRIMS04_Guam_Japan_v1.0.txt
		let fullString = try! String(contentsOfURL: NSURL(string: URLString)!)
        let allRows = fullString.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        let dataRows = allRows.filter { $0 != "" && !$0.hasPrefix("%")
        }
        // This smells a bit. Escape the newline because I'm building a multiline JavaScript string.
        let dataString = dataRows.joinWithSeparator("\\\r\n")

        let startupScriptSource = "dataString = '" + dataString + "';"

        let userScript = WKUserScript(source: startupScriptSource, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        webView?.configuration.userContentController.addUserScript(userScript)
        let localPath = NSBundle.mainBundle().pathForResource("CIRIMSTimeSeries", ofType: "html")
        webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
            // FIXME: what does this parameter mean? Must be a fileURL (undocumented)
            allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
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

