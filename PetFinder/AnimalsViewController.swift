//
//  AnimalsViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/20/22.
//

import Foundation
import UIKit

class AnimalsViewController: UITableViewController {
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAnimals()
    }
    
    // MARK: - API
    
    private func fetchAnimals() {
        //TODO: CALL OUR fetchAnimals Service to be created.
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        view.backgroundColor = .yellow
        navigationItem.title = "Results of Animals"
    }
    
    
}
