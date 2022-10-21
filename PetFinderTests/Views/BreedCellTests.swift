//
//  BreedCellTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/21/22.
//

import XCTest
@testable import PetFinder

final class BreedCellTests: XCTestCase {

    func test_BreedCell_InitWithCoder() {
        let sut = BreedCell(coder: NSCoder())
        XCTAssertNil(sut)
    }

}
