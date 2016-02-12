//
//  TweetCell.swift
//  Twitter
//
//  Created by Chun Kwok on 2/6/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCtLabel: UILabel!
    @IBOutlet weak var favCtLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweetIdSpec: String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
        var imageView = avatarImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        */
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetIdSpec!)
        
    }

    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweetIdSpec!)
    }
    
    /*
    func imageTapped(img: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let tweetView: TweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        tweetView.performSegueWithIdentifier("UserProfileViewController", sender: nil)
    }
*/
}
