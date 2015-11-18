//
//  ViewController.swift
//  JS Conversation
//
//  Created by Hal Mueller on 11/10/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

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

        newWebView.configuration.userContentController.addScriptMessageHandler(self, name: "barsCounted")

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadSimpleD3(sender: AnyObject) {
        hitherButton.enabled = false
        yonButton.enabled = false
        webView?.configuration.userContentController.removeAllUserScripts()

        let localPath = NSBundle.mainBundle().pathForResource("simpleD3", ofType: "html")
        webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
            // FIXME: what does this parameter mean? Must be a fileURL (undocumented)
            allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
    }

    @IBAction func loadSimplePlusInit(sender: AnyObject) {
        hitherButton.enabled = true
        yonButton.enabled = true
        webView?.configuration.userContentController.removeAllUserScripts()

        let startupScriptSource = "jsonString1 = '[{\"name\": \"Lou\", \"value\": 129}, {\"name\": \"Lloyd\", \"value\": 2}, {\"name\": \"Scott\", \"value\": 0}]';"
        let userScript = WKUserScript(source: startupScriptSource, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        webView?.configuration.userContentController.addUserScript(userScript)

        let localPath = NSBundle.mainBundle().pathForResource("simplePlusInit", ofType: "html")
        webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
            // FIXME: what does this parameter mean? Must be a fileURL (undocumented)
            allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
    }
    

    @IBAction func loadEnterExit(sender: AnyObject) {
        hitherButton.enabled = true
        yonButton.enabled = true
        webView?.configuration.userContentController.removeAllUserScripts()

        let localPath = NSBundle.mainBundle().pathForResource("enterExit", ofType: "html")
        webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
            // FIXME: what does this parameter mean? Must be a fileURL (undocumented)
            allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
    }
    
    @IBAction func loadBarsOne(sender: AnyObject) {
        hitherButton.enabled = true
        yonButton.enabled = true
        webView?.configuration.userContentController.removeAllUserScripts()

        let localPath = NSBundle.mainBundle().pathForResource("barsOne", ofType: "html")
        webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
            // FIXME: what does this parameter mean? Must be a fileURL (undocumented)
            allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
    }
    
    @IBAction func loadBarsTwo(sender: AnyObject) {
        hitherButton.enabled = true
        yonButton.enabled = true
        webView?.configuration.userContentController.removeAllUserScripts()

        let startupScriptSource = "jsonString = '[{\"name\": \"Lou\", \"value\": 129}, {\"name\": \"Lloyd\", \"value\": 2}, {\"name\": \"Scott\", \"value\": 1}]';"
        let userScript = WKUserScript(source: startupScriptSource, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        webView?.configuration.userContentController.addUserScript(userScript)
		
		let reloadScript = WKUserScript(source: "reload(jsonString)",
			injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        webView?.configuration.userContentController.addUserScript(reloadScript)
		
        let localPath = NSBundle.mainBundle().pathForResource("barsOne", ofType: "html")
        webView?.loadFileURL(NSURL(fileURLWithPath: localPath!),
            // FIXME: what does this parameter mean? Must be a fileURL (undocumented)
            allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
    }
    
    @IBAction func yon(sender: AnyObject) {
        print("running yon")
		let valuesAsJSONString = "[{\"name\": \"Lou\", \"value\": 129}, {\"name\": \"Lloyd\", \"value\": 2}, {\"name\": \"Scott\", \"value\": 1}]"

        print (valuesAsJSONString)
        let fullJavaScriptCall = "reload('\(valuesAsJSONString)')"
        print (fullJavaScriptCall)
        self.webView?.evaluateJavaScript(fullJavaScriptCall, completionHandler: { (result, error) -> Void in
            print(error)
        })
    }

    @IBAction func hither(sender: AnyObject) {
        print("running hither")
		let newValuesAsArray = [["name": "Kirk", "value": 1], ["name": "Picard", "value": 2], ["name": "Sisko", "value": 3], ["name": "Janeway", "value": 4], ["name": "Archer", "value": 5]]
		let valuesAsJSONData = try! NSJSONSerialization.dataWithJSONObject(newValuesAsArray, options: NSJSONWritingOptions(rawValue: 0))
		print (valuesAsJSONData)
		let valuesAsJSONString = NSString(data: valuesAsJSONData, encoding: NSUTF8StringEncoding)! as String
		print (valuesAsJSONString)
		let fullJavaScriptCall = "reload('\(valuesAsJSONString)')"
		print (fullJavaScriptCall)
		self.webView?.evaluateJavaScript(fullJavaScriptCall, completionHandler: { (result, error) -> Void in
			print(error)
		})
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

    // MARK: - WKScriptMessageHandler
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if message.name == "barsCounted" {
            let numbers = message.body as! NSArray
            print (numbers.count)
            self.resultLabel.text = "\(numbers.count) numbers"
        }
    }

    // MARK: - WKUIDelegate
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let alertController = UIAlertController(title: message,
            message: frame.request.URL!.description + " " + frame.securityOrigin.description,
            preferredStyle: .Alert)

        let confirmAtion = UIAlertAction(title: "Sure!", style: .Default) { (UIAlertAction) -> Void in
            completionHandler()
        }
        let mehAction = UIAlertAction(title: "Meh", style: .Cancel) { (UIAlertAction) -> Void in
            completionHandler()
        }
        let nahAction = UIAlertAction(title: "Go away", style: .Destructive) { (UIAlertAction) -> Void in
            completionHandler()
        }
        alertController.addAction(mehAction)
        alertController.addAction(confirmAtion)
        alertController.addAction(nahAction)
        presentViewController(alertController, animated: true) { () -> Void in

        }

    }

}

