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
        setupUI()
        fetchAnimalTypes()
    }
    
    // MARK: - API
    
    private func fetchAnimalTypes() {
        print("Call the PetfinderAPIManager.shared.fetchAnimalTypes service now..")
        PetfinderAPIManager.shared.fetchAnimalTypes { animalTypes in
            print("Should have an array of Animal Types now, such as: Dog, Bird, Cat, Etc...")
        }
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        self.navigationItem.title = "HomeView"
        
        let mainlabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 60))
        mainlabel.backgroundColor = UIColor.systemPink
        mainlabel.text = "Welcome to your new Pet!"
        self.view.addSubview(mainlabel)
        
        mainlabel.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: mainlabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: mainlabel, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .top, multiplier: 1, constant: 80)
        let widthConstraint = NSLayoutConstraint(item: mainlabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: mainlabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

    }

}

