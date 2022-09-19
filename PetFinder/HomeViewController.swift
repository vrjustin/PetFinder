//
//  ViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 9/19/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        
        //Test if we can access our API Secrets now.
        if let client_id = Bundle.main.infoDictionary?["CLIENT_ID"] as? String, let client_secret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String  {
            print("Ok clientID is: \(client_id)")
            print("Ok clientSecret is: \(client_secret)")
        }
        
    }


}

