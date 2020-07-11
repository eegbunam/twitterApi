//
//  TweetCell.swift
//  Twitter
//
//  Created by Ebuka Egbunam on 6/23/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var favorite: UIButton!
    
    @IBOutlet weak var retweet: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var retweeted : Bool = false
    var tweet : [String : Any]!
    var favorited : Bool = false
    var tweetId : Int = -1
    func setFavorite(isFavorite : Bool){
         favorited = isFavorite
        if favorited {
            favorite.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }else{
             favorite.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
     }
    
    
    func setRetweet(_ isRetweeted : Bool){
        if isRetweeted{
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweet.isEnabled = false
            return
        }
        retweet.setImage(UIImage(named: "retweet-icon"), for: .normal)
    }
    
    
    @IBAction func favorite(_ sender: UIButton) {
        let toBeFoarited = !favorited
        if toBeFoarited {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorite: true)
            }, failure: { (error) in
                print("error favorriting tweet")
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorite: false)
            }, failure: { (error) in
                print("error unfavoriting tweet")
            })
        }
    }
    
    
    
    @IBAction func retweet(_ sender: UIButton) {
        
        TwitterAPICaller.client?.retweetTweet(tweetID: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("error retwetting \(error.localizedDescription)")
        })
    }
    

}
