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
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
