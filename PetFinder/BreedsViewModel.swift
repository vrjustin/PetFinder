//
//  BreedsViewModel.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation

struct BreedsViewModel {
    private let currentAnimal: AnimalType
}

extension BreedsViewModel {
    init(_ forCurrentAnimalType: AnimalType) {
        self.currentAnimal = forCurrentAnimalType
    }
}

extension BreedsViewModel {
    var currentAnimalName: String {
        return currentAnimal.name
    }
}
