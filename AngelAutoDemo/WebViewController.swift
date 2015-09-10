//
//  WebViewController.swift
//  AngelAutoDemo
//
//  Created by Jun Mao on 8/28/15.
//  Copyright (c) 2015 Syracuse University. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the webview
        let requestURL = NSURL(string: "http://www.angellk.com")
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        
        // Action to show the rear sidebar
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
