//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Chun Kwok on 2/3/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tweetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name:UIKeyboardWillShowNotification, object: nil);
    
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tweets != nil {
            return (tweets?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = tweets![indexPath.row]
        cell.nameLabel.text = tweet.user!.name
        cell.atNameLabel.text = "@" + tweet.user!.screenname!
        cell.avatarImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        cell.messageLabel.text = tweet.text
        cell.favCtLabel.text = String(tweet.favCount!)
        cell.retweetCtLabel.text = String(tweet.retweetCount!)
        cell.tweetIdSpec = tweet.tweetId
        let elapsedTime = NSDate().timeIntervalSinceDate(tweet.createdAt!)
        let duration = Int(elapsedTime)
        var finalTime = "0"
        
        if duration / (360 * 24) >= 1 {
            finalTime = String(duration / (360 * 24)) + "d"
        }
        else if duration / 360 >= 1 {
            finalTime = String(duration / 360) + "h"
            
        }
        else if duration / 60 >= 1 {
            finalTime = String(duration / 60) + "min"
        }
        else {
            finalTime = String(duration) + "s"
        }
        
        cell.timeLabel.text = String(finalTime)
        
        
        var imageView = cell.avatarImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }

    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UserProfileViewController" {
            let tweet = sender as! Tweet
            let userProfileViewController = segue.destinationViewController as! UserProfileViewController
            userProfileViewController.user = tweet.user
        }
        else if sender is UIButton {
            
        }
        else {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.tweet = tweet
        }
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        let tapLocation = sender.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        let tweet = tweets![indexPath!.row]
        
        self.performSegueWithIdentifier("UserProfileViewController", sender: tweet)
    }

    /*
    func keyboardWasShown(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 40
        })
    }
*/
    
    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.makeTweet(tweetTextField.text!)
        tweetTextField.text = ""

    }


}
