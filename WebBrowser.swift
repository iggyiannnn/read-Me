//
//  WebBrowser.swift
//  HiSilver
//
//  Created by jernkuan on 7/12/15.
//  Copyright © 2015 hisilver. All rights reserved.
//

import Foundation
import UIKit

class WebBrowser: UIViewController, UIWebViewDelegate {
    
    @IBAction func back(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var webView: UIWebView!
    var targetUrl:String=""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let url = NSURL (string:targetUrl)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
        webView.delegate=self
        print("loading webpage"+targetUrl)
    }
}
