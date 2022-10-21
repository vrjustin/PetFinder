//
//  AnimalTypeCellTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/19/22.
//

import XCTest
@testable import PetFinder

final class AnimalTypeCellTests: XCTestCase {

    func test_AnimalTypeCell_InitWithCoder() {
        let sut = AnimalTypeCell(coder: NSCoder())
        XCTAssertNil(sut)
    }

}
