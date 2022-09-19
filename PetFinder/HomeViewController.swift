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
        
        PetfinderAPIManager.shared.fetchAnimalTypes(completion: { animal_types in
            print(animal_types)
        })
        
    }

    

}

