//
//  AnimalsViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/20/22.
//

import Foundation
import UIKit

private let animalCellReuseIdentifier = "animalCellReuseIdentifier"

class AnimalsViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    var viewModel: AnimalsViewModel!
    
    private var animals = [Animal]() {
        didSet {
            if animals.count > 0 {
                tableView.reloadData()
            } else {
                let ac = UIAlertController(title: "No Results", message: "No Results found", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                ac.addAction(okAction)
                self.present(ac, animated: true)
            }
        }
    }
    
    // MARK: - LIFECYCLE
    
    init(_ animalsViewModel: AnimalsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = animalsViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAnimals()
    }
    
    // MARK: - API
    
    private func fetchAnimals() {

        let apiManager = PetfinderAPIManager()
        
        //TODO: Remove hard-coded location & distance from location. These should come from the users's device location if allowed or
        //they should input the zip they want to search. And a Search distance.
        let requestModel = FetchAnimalRequestModel(animalType: viewModel.currentAnimalType, breed: viewModel.currentAnimalBreed, location: "90210", distance: "25")
                
        apiManager.fetchAnimalForSelectedBreed(requestModel: requestModel) { animals in
            if let animals = animals {
                self.animals = animals
            }
        }
        
        
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        view.backgroundColor = .yellow
        navigationItem.title = "Results of Animals"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(AnimalCell.self, forCellReuseIdentifier: animalCellReuseIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
    
}

extension AnimalsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: animalCellReuseIdentifier, for: indexPath) as! AnimalCell
        let animal = animals[indexPath.row]
        
        cell.viewModel = AnimalViewModel(withAnimal: animal)
        
        return cell
    }
    
}
