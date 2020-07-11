//
//  TweetingViewController.swift
//  Twitter
//
//  Created by Ebuka Egbunam on 7/7/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetingViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Tweet(_ sender: Any) {
        
        if !tweetTextView.text.isEmpty{
            TwitterAPICaller.client?.postTweet(tweet: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                let controller = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
            })
        }
        
    }
    
    
}
