//
//  DetailViewController.swift
//  Twitter
//
//  Created by Chun Kwok on 2/9/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var retweetCtLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likesCtLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var replyTextField: UITextField!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func onReply(sender: AnyObject) {
        TwitterClient.sharedInstance.reply(replyTextField.text!)
        replyTextField.text = ""
    }

    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet.tweetId!)
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet.tweetId!)
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
