//
//  ViewController.swift
//  JS Conversation
//
//  Created by Hal Mueller on 11/10/15.
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

        self.subView.addSubview(newWebView)
        newWebView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            NSLayoutConstraint(item: newWebView, attribute: .Leading, relatedBy: .Equal, toItem: subView, attribute: .Leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: newWebView, attribute: .Trailing, relatedBy: .Equal, toItem: subView, attribute: .Trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: newWebView, attribute: .Top, relatedBy: .Equal, toItem: subView, attribute: .Top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: newWebView, attribute: .Bottom, relatedBy: .Equal, toItem: subView, attribute: .Bottom, multiplier: 1.0, constant: 0.0),
        ]
        NSLayoutConstraint.activateConstraints(constraints)

        let localPath = NSBundle.mainBundle().pathForResource("simpleD3", ofType: "html")
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

