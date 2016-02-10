//
//  DetailViewController.swift
//  Twitter
//
//  Created by Chun Kwok on 2/9/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var retweetCtLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likesCtLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        print(tweet)
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenname
        descLabel.text = tweet.text
        retweetLabel.text = ""
        likeLabel.text = ""
        retweetCtLabel.text = ""
        likesCtLabel.text = ""
        if tweet.retweetCount > 0 {
            retweetCtLabel.text = String(tweet.retweetCount!)
            retweetLabel.text = "Retweets"
        }
        if tweet.favCount > 0 {
            likesCtLabel.text = String(tweet.favCount!)
            likeLabel.text = "Likes"
        }
        timeLabel.text = tweet.createdAtString
        profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        /*
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
        */
        return cell
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
