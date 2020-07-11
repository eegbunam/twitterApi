//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Ebuka Egbunam on 6/23/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    

    
    @IBOutlet weak var tableview: UITableView!
    var ListDictionary : [[String:Any]] = [[:]]
    let myrefreshcontroller = UIRefreshControl()
    var numberOfTweets : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        myrefreshcontroller.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableview.refreshControl = myrefreshcontroller
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 150
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadTweets()
    }
    
    
    @objc func loadTweets() -> Void {
        numberOfTweets = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: ["count":numberOfTweets], success: { (dictionary)  in
            for dic in dictionary{
                print(dic)
                self.ListDictionary.append(dic as! [String : Any])
                self.tableview.reloadData()
                self.myrefreshcontroller.endRefreshing()
                
            }
        }, failure: { (error) in
            print(error)
        })
        
    }
    
    
    @objc func  loadMoreTweets(){
        numberOfTweets += 10
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: ["count":numberOfTweets], success: { (dictionary)  in
            for dic in dictionary{
                print(dic)
                self.ListDictionary.append(dic as! [String : Any])
                self.tableview.reloadData()
                self.myrefreshcontroller.endRefreshing()
                
            }
        }, failure: { (error) in
            print(error)
        })
    }
    
    
 
    
    @IBAction func logout(_ sender: Any) {
        TwitterAPICaller.client?.deauthorize()
        UserDefaults.standard.set(false, forKey: "login")
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension TweetsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TweetCell {

            let tweet = ListDictionary[indexPath.row]
            let user = ListDictionary[indexPath.row]["user"] as? [String : Any]
            let name = user?["name"]  as? String
              cell.usernameLabel.text = name
            cell.tweetContentLabel.text = tweet["text"] as? String
            
            if let imageurl = URL(string: user?["profile_image_url_https"] as? String ?? "") {
                 let data = try? Data(contentsOf: imageurl)
                cell.profileImage.image = UIImage(data: data ?? Data())
                
            }
            cell.setFavorite(isFavorite: tweet["favorited"] as? Bool ?? false)
            
            cell.tweetId = tweet["id"] as? Int ?? -1
            cell.setRetweet(tweet["retweeted"] as? Bool ?? false)
            
            
           
    
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row  == ListDictionary.count - 3 {
            loadMoreTweets()
        }
    }
    
    
}
