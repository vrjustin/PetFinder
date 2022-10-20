//
//  PetfinderAPIManagerTests.swift
//  PetFinderTests
//
//  Created by Justin Maronde on 10/20/22.
//

import XCTest
@testable import PetFinder
@testable import Alamofire

final class PetfinderAPIManagerTests: XCTestCase {

    private var sut: PetfinderAPIManager!
    
    override func setUp() {
        super.setUp()
        
        TokenManager.shared.clearAccessToken()
        
        let sessionManager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockURLProtocol.self]
                return configuration
            }()
            
            return Session(configuration: configuration)
        }()
        
        sut = PetfinderAPIManager(sessionManager: sessionManager)
    }
    
    override func tearDown() {
        super.tearDown()
        TokenManager.shared.clearAccessToken()
        sut = nil
    }

    func test_PetfinderAPIManager_fetchAccessToken_savesToTokenManagerUponSuccess() {
        
        let jsonStubData = """
        {
        "token_type": "Bearer",
        "access_token": "SomeNotRealJWTTokenForTesting"
        }
        """.data(using: .utf8)
        
        MockURLProtocol.stubResponseData = jsonStubData
        let expectation = XCTestExpectation(description: "fetchToken response expectation")
        sut.fetchAccessToken { isSuccess in
            XCTAssertTrue(isSuccess, "Decoding of PetfinderAccessToken failed.")
            let storedToken = TokenManager.shared.fetchAccessToken()
            XCTAssertEqual("SomeNotRealJWTTokenForTesting", storedToken)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 45.0)
    }
    
    func test_PetfinderAPIManager_fetchAccessToken_errorsWhenInvalidResponseDecoding() {
        let jsonStubData = """
        {
        "token_type": "Bearer",
        "invalid_json_Key_for_access_token": "SomeNotRealJWTTokenForTesting"
        }
        """.data(using: .utf8)
        
        MockURLProtocol.stubResponseData = jsonStubData
        let expectation = XCTestExpectation(description: "fetchToken failed response expectation")
        
        sut.fetchAccessToken { isSuccess in
            XCTAssertFalse(isSuccess, "Decoding of PetfinderAccessToken should have failed with that JSON but did not!")
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 45.0)
        
    }

}
