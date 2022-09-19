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
        
        PetfinderAPIManager.shared.fetchAccessToken(accessCode: "WhatIsThisCode") { [self] isSuccess in
          if !isSuccess {
            print("Error fetching access token")
          }
          navigationController?.popViewController(animated: true)
        }

        
    }


}

