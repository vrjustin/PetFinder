//
//  AnimalTypeViewModel.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation

struct AnimalTypesViewModel {
    let animalTypes: [AnimalType]
}

extension AnimalTypesViewModel {
    
    func numberOfAnimalTypesToDisplay() -> Int {
        return self.animalTypes.count
    }
    
    func animalTypeAtIndex(_ index: Int) -> AnimalTypeViewModel {
        let animalType = self.animalTypes[index]
        return AnimalTypeViewModel(animalType)
    }
    
}


struct AnimalTypeViewModel {
    private let animalType: AnimalType
}

extension AnimalTypeViewModel {
    init(_ animalType: AnimalType) {
        self.animalType = animalType
    }
}

extension AnimalTypeViewModel {
    var name: String {
        return animalType.name
    }
}
