//
//  AnimalTypeViewModel.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation
import UIKit

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
    var image: UIImage {
        var animalTypeImage: UIImage
        
        switch animalType.name.lowercased() {
        case "dog":
            animalTypeImage = UIImage(named: "dog")!
        case "cat":
            animalTypeImage = UIImage(named: "cat")!
        case "rabbit":
            animalTypeImage = UIImage(named: "rabbit")!
        case "small & furry":
            animalTypeImage = UIImage (named: "guinea-pig")!
        case "horse":
            animalTypeImage = UIImage(named: "horse")!
        case "bird":
            animalTypeImage = UIImage(named: "bird")!
        case "scales, fins & other":
            animalTypeImage = UIImage(named: "fish")!
        case "barnyard":
            animalTypeImage = UIImage(named: "cow")!
        
        default:
            print("Still Images for: \(animalType.name)")
            animalTypeImage = UIImage(named: "dog")!
        }
        
        
        return animalTypeImage
    }
}
