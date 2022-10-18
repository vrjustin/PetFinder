//
//  ViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 9/19/22.
//

import UIKit

private let animalTypesCellReuseIdentifier = "animalTypesCellReuseIdentifier"

class HomeViewController: UITableViewController {
    
    private var animalTypes = [AnimalType]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAnimalTypes()
    }
    
    // MARK: - API
    
    private func fetchAnimalTypes() {
        PetfinderAPIManager.shared.fetchAnimalTypes { animalTypes in
            guard let animalTypes = animalTypes else { return }
            self.animalTypes = animalTypes.types
        }
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        configureTableView()
    }
    
    private func configureTableView() {
        view.backgroundColor = .white
        navigationItem.title = "Select The Animal Type to Start"
        
        tableView.register(AnimalTypeCell.self, forCellReuseIdentifier: animalTypesCellReuseIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }

}

// MARK: - TableView DataSource

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: animalTypesCellReuseIdentifier, for: indexPath) as! AnimalTypeCell
        let animalType = AnimalType(name: animalTypes[indexPath.row].name, coats: animalTypes[indexPath.row].coats, colors: animalTypes[indexPath.row].colors, genders: animalTypes[indexPath.row].genders)
        cell.viewModel = AnimalTypeViewModel(animalType)
        return cell
    }
}

// MARK: - TableView Delegate

extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did SelectRowAt: \(animalTypes[indexPath.row])")
    }
}
