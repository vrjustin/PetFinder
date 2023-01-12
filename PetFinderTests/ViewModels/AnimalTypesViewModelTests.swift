//
//  AnimalTypesViewModelTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 1/12/23.
//

import XCTest
@testable import PetFinder

class AnimalTypesViewModelTests: XCTestCase {
    var animalTypes: [AnimalType]!
    var sut: AnimalTypesViewModel!
    
    override func setUp() {
        super.setUp()
        
        animalTypes = [AnimalType(name: "Dog", coats: ["short", "medium"], colors: ["brown", "black"], genders: ["male", "female"]),
                       AnimalType(name: "Cat", coats: ["short", "long"], colors: ["black", "white"], genders: ["male", "female"]),
                       AnimalType(name: "Fish", coats: ["scales"], colors: ["yellow", "blue"], genders: ["male", "female"])]
        sut = AnimalTypesViewModel(animalTypes: animalTypes)
    }
    
    func testNumberOfAnimalTypesToDisplay() {
        XCTAssertEqual(sut.numberOfAnimalTypesToDisplay(), 3)
    }

    func testAnimalsTypeAtIndex() {
        let animalTypeViewModel = sut.animalTypeAtIndex(1)
        XCTAssertEqual(animalTypeViewModel.name, "Cat")
    }
}

