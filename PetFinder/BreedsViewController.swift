//
//  BreedsViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation
import UIKit

class BreedsViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    var viewModel: BreedsViewModel!
    
    // MARK: - LIFECYCLE
    
    init(_ breedsViewModel: BreedsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = breedsViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        navigationItem.title = "Select a Breed for the \(viewModel.currentAnimalName)"

        configureTableView()
    }
    
    private func configureTableView() {
        view.backgroundColor = .yellow
        
        //TODO: register our BreedCell
        //TODO: Rest of tablview setup, styling, etc.
    }
    
}
