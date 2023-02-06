//
//  BreedCellTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 2/6/23.
//

import XCTest
@testable import PetFinder

final class BreedCellTests: XCTestCase {

    func testConfigureSetsLabelText() {
        
        let breed = Breed(name: "Labrador Retriever")
        let viewModel = BreedViewModel(breed)
        let cell = BreedCell()
        
        cell.viewModel = viewModel
        
        XCTAssertEqual(cell.breedNameLabel.text, breed.name)
    }

}
