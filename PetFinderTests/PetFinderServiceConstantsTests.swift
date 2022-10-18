//
//  PetFinderServiceConstantsTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/18/22.
//

import XCTest
@testable import PetFinder

final class PetFinderServiceConstantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PetfinderServiceConstants_getBreedsReturnsProperString() {
        
        let ut = PetfinderServiceConstants.getBreedsURLString(AnimalType(name: "Dog", coats: [], colors: [], genders: []))
        
        XCTAssertEqual(ut, "https://api.petfinder.com/v2/types/dog/breeds")
    }

}
