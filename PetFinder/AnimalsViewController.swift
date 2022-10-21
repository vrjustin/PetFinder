//
//  AnimalsViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/20/22.
//

import Foundation
import UIKit

class AnimalsViewController: UIViewController {
    
    // MARK: - LIFECYCLE
    
    private var animals = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAnimals()
    }
    
    // MARK: - API
    
    private func fetchAnimals() {
        let apiManager = PetfinderAPIManager()
        //TODO: Remove the hardcoded test values
        let testType = AnimalType(name: "Dog", coats: [], colors: [], genders: [])
        let testBreed = Breed(name: "Australian Shepherd")
        
        //TODO GEt the Actual values to put into the requestModel from the viewModel
        let requestModel = FetchAnimalRequestModel(animalType: testType, breed: testBreed)
        
        //END HARDCODING
        
        apiManager.fetchAnimalForSelectedBreed(requestModel: requestModel) { animals in
            print("Do we have our animals")
            if let animals = animals {
                print(animals)
            }
        }
        
        
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        view.backgroundColor = .yellow
        navigationItem.title = "Results of Animals"
    }
    
    
}
