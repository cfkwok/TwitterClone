//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Chun Kwok on 2/12/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCtLabel: UILabel!
    @IBOutlet weak var followingCtLabel: UILabel!
    @IBOutlet weak var followersCtLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = user!.name!
        screenNameLabel.text = "@" + user!.screenname!
        tweetCtLabel.text = String(user!.dictionary["statuses_count"]!)
        followingCtLabel.text = String(user!.dictionary["friends_count"]!)
        followersCtLabel.text = String(user!.dictionary["followers_count"]!)
        profileImageView.setImageWithURL(NSURL(string: user!.profileImageUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
