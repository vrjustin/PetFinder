//
//  BreedsViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation
import UIKit

private let animalbreedsCellReuseIdentifier = "animalBreedsCellReuseIdentifier"


class BreedsViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    var viewModel: BreedsViewModel!
    
    private var breeds = [Breed]() {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        fetchAnimalBreeds()
    }
    
    // MARK: - API
    
    private func fetchAnimalBreeds() {
        let apiManager = PetfinderAPIManager()
        apiManager.fetchBreedsForAnimal(viewModel.currentAnimalType) { breeds in
            guard let breeds = breeds else { return }
            self.breeds = breeds
        }
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Select a Breed for the \(viewModel.currentAnimalName)"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(BreedCell.self, forCellReuseIdentifier: animalbreedsCellReuseIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
    
}


extension BreedsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: animalbreedsCellReuseIdentifier, for: indexPath) as! BreedCell
        let breed = Breed(name: breeds[indexPath.row].name)
        cell.viewModel = BreedViewModel(breed)
        return cell
    }
}

extension BreedsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? BreedCell
        guard let selectedBreed = selectedCell?.viewModel?.currentBreed else { return }
        let animalsViewModel = AnimalsViewModel(breed: selectedBreed, animalType: viewModel.currentAnimalType)
        let controller = AnimalsViewController(animalsViewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
