//
//  AnimalTypeCellTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/19/22.
//

import XCTest
@testable import PetFinder

final class AnimalTypeCellTests: XCTestCase {
    
    var cell: AnimalTypeCell!
    
    override func setUp() {
        super.setUp()
        cell = AnimalTypeCell()
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func test_AnimalTypeCell_InitWithCoder() {
        cell = AnimalTypeCell(coder: NSCoder())
        XCTAssertNil(cell)
    }
    
    func test_AnimalTypeCell_configure_setsImageAndLabel() {
        let animalType = AnimalType(name: "Dog", coats: [], colors: [], genders: [])
        let viewModel = AnimalTypeViewModel(animalType)
        cell.viewModel = viewModel
        
        XCTAssertEqual(cell.animalTypeLabel.text, "Dog")
    }

}
