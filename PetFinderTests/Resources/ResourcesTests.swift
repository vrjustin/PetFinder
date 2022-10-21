//
//  ResourcesTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/21/22.
//

import XCTest

final class ResourcesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Resources_PetfinderApiConfig_isPresent() {
        let client_id = Bundle.main.infoDictionary?["CLIENT_ID"] as? String
        let client_secret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String
        
        XCTAssertNotEqual(client_id, "", "Did not return the proper and expected CLIENT_ID")
        XCTAssertNotEqual(client_secret, "Did not return the proper and expected CLIENT_SECRET")
    }

}
