//
//  TwitterClient.swift
//  Twitter
//
//  Created by Chun Kwok on 2/2/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "x0KBtpdUdvVOZDVND52zkF83O"
let twitterConsumerSecret = "8deJlyLZePqVdZOfShZ9iT5rbs47FmBbsRFwemohi3PMgbRZWh"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) {(error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func retweet(tweetId: String) {
        
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful retweet")
            }) { (opreation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't retweet")
        }
    }
    
    func favorite(tweetId: String) {
        
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(tweetId)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful fav")
            }) { (opreation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't fav")
        }
    }
    
    func reply(text: String, statusId: String) {
        var escapedText = text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        print("1.1/statuses/update.json?status=\(escapedText!)?in_reply_to_status_id=\(statusId)")
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(escapedText!)&in_reply_to_status_id=\(statusId)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful reply")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't reply")
        }

    }
    
    func getProfile(screenName: String!) {
        TwitterClient.sharedInstance.GET("1.1/users/show.json?screen_name=\(screenName!)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully got user")
            print("\(response)")
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Can't get user")
        }
        
    }
}
