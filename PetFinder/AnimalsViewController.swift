//
//  AnimalsViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/20/22.
//

import Foundation
import UIKit

private let animalCellReuseIdentifier = "animalCellReuseIdentifier"

class AnimalsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    static let filterValueChanged = Notification.Name("filterValueChanged")
    var viewModel: AnimalsViewModel!
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .gray
        tv.dataSource = self
        return tv
    }()
    
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
        setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - API
    
    private func fetchAnimals() {

        let apiManager = PetfinderAPIManager()
        
        //TODO: Remove hard-coded location & distance from location. These should come from the users's device location if allowed or
        //they should input the zip they want to search. And a Search distance.
        let requestModel = FetchAnimalRequestModel(animalType: viewModel.currentAnimalType, breed: viewModel.currentAnimalBreed, location: "48334", distance: "25")
                
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
        configureNavbar()
        configureTableView()
    }
    
    private func configureNavbar() {
        print("OK lets add a filter icon to the top right of the navbar..")
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(filterButtonTapped))

        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.register(AnimalCell.self, forCellReuseIdentifier: animalCellReuseIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilterValueChanged(_:)), name: AnimalsViewController.filterValueChanged, object: nil)

    }
    
    // MARK: - ACTIONS

    @objc func filterButtonTapped() {
        print("Filter Button Tapped")
        let filterVC = FilterViewController()
        filterVC.modalPresentationStyle = .formSheet
        filterVC.modalTransitionStyle = .coverVertical
        present(filterVC, animated: true)
    }
    
    @objc func handleFilterValueChanged(_ notification: Notification) {
        if let value = notification.object as? Float {
            // Update your AnimalsViewController with the new value
            print("AnimalsVC received value: \(value)")
        }
    }

    
}

extension AnimalsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: animalCellReuseIdentifier, for: indexPath) as! AnimalCell
        let animal = animals[indexPath.row]

        cell.viewModel = AnimalViewModel(withAnimal: animal)

        return cell
    }

}
