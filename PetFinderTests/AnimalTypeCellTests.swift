//
//  AnimalTypeCellTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/19/22.
//

import XCTest
@testable import PetFinder

final class AnimalTypeCellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AnimalTypeCell_InitWithCoder() {
        let sut = AnimalTypeCell(coder: NSCoder())
        XCTAssertNil(sut)
    }

}
