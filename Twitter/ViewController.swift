//
//  ViewController.swift
//  Twitter
//
//  Created by Chun Kwok on 2/2/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            else {
                
            }
        }
        
        
    }

}

