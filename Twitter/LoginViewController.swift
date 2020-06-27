//
//  LoginViewController.swift
//  Twitter
//
//  Created by Ebuka Egbunam on 6/23/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "login"){
            gotoHome()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Login(_ sender: Any) {
        
        let url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url,  success:  {
            
            
            UserDefaults.standard.set(true, forKey: "login")
            
            self.gotoHome()

            
        }, failure: { (error) in
            let alertController = UIAlertController(title: "Errror", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        })
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func gotoHome(){
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tweets")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "tweets", sender: self)
        }
        
    }
    
}
