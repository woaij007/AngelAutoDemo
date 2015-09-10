//
//  DateViewController.swift
//  AngelAutoDemo
//
//  Created by Jun Mao on 8/28/15.
//  Copyright (c) 2015 Syracuse University. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var dateLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get and present date
        let date = NSDate();
        var formatter = NSDateFormatter();
        formatter.dateFormat = "MM/dd/yyyy";
        let localDate = formatter.stringFromDate(date);
        dateLabel.text = "\(localDate)"
        
//        // UTC date
//        formatter.timeZone = NSTimeZone(abbreviation: "UTC");
//        let utcTimeZoneStr = formatter.stringFromDate(date);
        
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
