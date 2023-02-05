//
//  AnimalViewModel.swift
//  PetFinder
//
//  Created by Justin Maronde on 2/4/23.
//

import Foundation

// ANIMALS
struct AnimalsViewModel {
    private let breed: Breed
    private let animalType: AnimalType
    var animals: [Animal]?
}

extension AnimalsViewModel {
    init(breed: Breed, animalType: AnimalType) {
        self.breed = breed
        self.animalType = animalType
    }
}

extension AnimalsViewModel {
    var currentAnimalType: AnimalType {
        return self.animalType
    }
    var currentAnimalBreed: Breed {
        return self.breed
    }
}

// ANIMAL
struct AnimalViewModel {
    private let animal: Animal
}

extension AnimalViewModel {
    init(withAnimal animal: Animal) {
        self.animal = animal
    }
}

extension AnimalViewModel {
    var animalId: String {
        return String(animal.id)
    }
    var name: String {
        return animal.name
    }
    var adoptableStatus: String {
        return animal.status
    }
    var currentAnimal: Animal {
        return self.animal
    }
    var photos: [[String:String]] {
        return self.animal.photos
    }
    var smallPhoto: String? {
        //TODO: Improve this..
        return self.animal.photos[0]["small"]
    }
}
