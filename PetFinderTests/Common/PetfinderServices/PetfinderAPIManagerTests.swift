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

        self.wait(for: [expectation], timeout: 1)
        
    }
    
    func test_PetfinderAPIManager_fetchAnimalTypes_givenAStoredToken_Validate_ReturnsArrayOfAnimalTypes() {
        
        let jsonStubData = """
        {
            "types": [
                {
                    "name": "Dog",
                    "coats": [
                        "Hairless",
                        "Short"
                    ],
                    "colors": [
                        "Black",
                        "White"
                    ],
                    "genders": [
                        "Male",
                        "Female"
                    ]
                }
            ]
        }
        """.data(using: .utf8)
        MockURLProtocol.stubResponseData = jsonStubData
        TokenManager.shared.saveAccessToken(accessToken: PetfinderAccessToken(accessToken: "someToken", tokenType: "Bearer"))
        let expectation = XCTestExpectation(description: "fetchAnimalTypes expected response")
        
        sut.fetchAnimalTypes { animalTypes in
            XCTAssertNotNil(animalTypes)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 45.0)
    }
    
    func test_PetfinderAPIManager_fetchAnimalTypes_givenNoStoredToken_Validate_ReturnsNil() {
        
        let jsonStubData = """
        {
            "types": [
                {
                    "name": "Dog",
                    "coats": [
                        "Hairless",
                        "Short"
                    ],
                    "colors": [
                        "Black",
                        "White"
                    ],
                    "genders": [
                        "Male",
                        "Female"
                    ]
                }
            ]
        }
        """.data(using: .utf8)
        MockURLProtocol.stubResponseData = jsonStubData
        let expectation = XCTestExpectation(description: "fetchAnimalTypes expected failed response")
        
        sut.fetchAnimalTypes { animalTypes in
            XCTAssertNil(animalTypes, "The fetchAnimalTypes DID not return nil - despite having no stored token in TokenManager")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 45.0)
    }
    
    func test_PetfinderAPIManager_fetchAnimalTypes_errorsWhenInvalidResponseDecoding() {
        let jsonStubData = """
        {
            "invalid_types": [
                {
                    "invalid_name": "Dog",
                    "coats": [
                        "Hairless",
                        "Short"
                    ],
                    "invalid_colors": [
                        "Black",
                        "White"
                    ],
                    "genders": [
                        "Male",
                        "Female"
                    ]
                }
            ]
        }
        """.data(using: .utf8)
        MockURLProtocol.stubResponseData = jsonStubData
        TokenManager.shared.saveAccessToken(accessToken: PetfinderAccessToken(accessToken: "someToken", tokenType: "Bearer"))

        let expectation = XCTestExpectation(description: "fetchAnimalTypes expected failed response")
        
        sut.fetchAnimalTypes { animalTypes in
            XCTAssertNil(animalTypes, "The fetchAnimalTypes DID not return nil - The decoding of AnimalTypes succeeded and should not have despite having invalid decodable json.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 45.0)
        
        
    }
    
    func test_PetfinderAPIManager_fetchBreedsForAnimal_givenAStoredToken_Validate_ReturnsArrayOfAnimalBreeds() {
        
        let jsonStubData = """
            {
                "breeds": [
                    {
                        "name": "Affenpinscher"
                    },
                    {
                        "name": "American Bulldog"
                    }
                ]
            }
            """.data(using: .utf8)
    
        MockURLProtocol.stubResponseData = jsonStubData
        TokenManager.shared.saveAccessToken(accessToken: PetfinderAccessToken(accessToken: "someToken", tokenType: "Bearer"))
        let expectation = XCTestExpectation(description: "fetchAnimalBreeds expected response")
        
        let dogAnimal = AnimalType(name: "Dog", coats: [], colors: [], genders: [])
        sut.fetchBreedsForAnimal(dogAnimal) { breeds in
            XCTAssertNotNil(breeds)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 45.0)
        
    }
    
    func test_PetfinderAPIManager_fetchBreedsForAnimal_givenNoStoredToken_Validate_ReturnsNil() {
        let jsonStubData = """
            {
                "breeds": [
                    {
                        "name": "Affenpinscher"
                    },
                    {
                        "name": "American Bulldog"
                    }
                ]
            }
            """.data(using: .utf8)
    
        MockURLProtocol.stubResponseData = jsonStubData
        let expectation = XCTestExpectation(description: "fetchAnimalBreeds expected response")
        
        let dogAnimal = AnimalType(name: "Dog", coats: [], colors: [], genders: [])
        sut.fetchBreedsForAnimal(dogAnimal) { breeds in
            XCTAssertNil(breeds)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 45.0)
    }
    
    func test_PetfinderAPIManager_fetchBreedsForAnimal_errorsWhenInvalidResponseDecoding() {
        let jsonStubData = """
            {
                "invalid_breeds": [
                    {
                        "name": "Affenpinscher"
                    },
                    {
                        "name": "American Bulldog"
                    }
                ]
            }
            """.data(using: .utf8)
    
        MockURLProtocol.stubResponseData = jsonStubData
        TokenManager.shared.saveAccessToken(accessToken: PetfinderAccessToken(accessToken: "someToken", tokenType: "Bearer"))

        let expectation = XCTestExpectation(description: "fetchAnimalBreeds expected response")
        
        let dogAnimal = AnimalType(name: "Dog", coats: [], colors: [], genders: [])
        sut.fetchBreedsForAnimal(dogAnimal) { breeds in
            XCTAssertNil(breeds)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 45.0)
    }

}
