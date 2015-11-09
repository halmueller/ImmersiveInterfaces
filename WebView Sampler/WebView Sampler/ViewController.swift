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
    
    var chosenSample: HTMLSample? {
        didSet {
            print("now playing", chosenSample)
            if let sample = chosenSample {
                if sample.isFile {
                    let localPath = NSBundle.mainBundle().pathForResource(sample.URLString, ofType: sample.filenameExtension)
                    webView?.loadFileURL(NSURL(fileURLWithPath: localPath!), allowingReadAccessToURL: NSURL(fileURLWithPath: "/"))
                }
                else {
                    let sampleURL = NSURL(string: sample.URLString)
                    let sampleRequest = NSURLRequest(URL: sampleURL!)
                    webView?.loadRequest(sampleRequest)
                }
            }
        }
    }
    
    let sampleOptions = [
        HTMLSample(description: "Hello World", URLString: "index", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "D3 Hello World", URLString: "simpleD3", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "D3 Collision Detection", URLString: "collisionDetection", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "Bar Chart (raw)", URLString: "simpleBars", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "Bar Chart (SVG)", URLString: "barchartSVG", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "Bar Chart (D3 SVG)", URLString: "barchartD3SVG", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "Bar Chart (JSON string)", URLString: "barchart", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "Bar Chart (external TSV, doesn't work)", URLString: "barchartExternalTSV", isFile: true, filenameExtension: "html"),
        HTMLSample(description: "Apple", URLString: "https://www.apple.com", isFile: false, filenameExtension: nil),
        HTMLSample(description: "CNN (insecure)", URLString: "http://www.cnn.com", isFile: false, filenameExtension: nil),
        HTMLSample(description: "CNN (secure)", URLString: "https://www.cnn.com", isFile: false, filenameExtension: nil),
        HTMLSample(description: "USGS (insecure, but has ATS exception)", URLString: "http://waterdata.usgs.gov/nwis/uv?12048000", isFile: false, filenameExtension: nil),
    ]
    
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
        //		print (subView.frame, subView.bounds)
        //		print (newWebView.frame, newWebView.bounds)
        //		print (sampleRequest)
        
        // Struts and springs
        // newWebView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        // Autolayout
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? SamplePickerTableViewController {
            destinationViewController.samplePresenter = self
        }
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
    
}

