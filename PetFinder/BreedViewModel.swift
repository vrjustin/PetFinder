//
//  BreedViewModel.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/20/22.
//

import Foundation

struct BreedsViewModel {
    private let animal: AnimalType
    var breeds: [Breed]?
}

extension BreedsViewModel {
    init(animal: AnimalType) {
        self.animal = animal
    }
}

extension BreedsViewModel {
    
    var currentAnimalType: AnimalType {
        return animal
    }
    
    var currentAnimalName: String {
        return animal.name
    }
    
}

struct BreedViewModel {
    private let breed: Breed
}

extension BreedViewModel {
    init(_ breed: Breed) {
        self.breed = breed
    }
}

extension BreedViewModel {
    var name: String {
        return breed.name
    }
}
