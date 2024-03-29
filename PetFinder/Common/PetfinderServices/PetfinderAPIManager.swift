/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Alamofire

class PetfinderAPIManager {
    
    private let sessionManager: Session
    private let configuration = URLSessionConfiguration.af.default
    
    init(sessionManager: Session = Session.default) {
        self.sessionManager = sessionManager
        self.configuration.timeoutIntervalForRequest = 30
    }
    
    func fetchAccessToken(completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let parameters = [
            "client_id": PetfinderServiceConstants.clientID,
            "client_secret": PetfinderServiceConstants.clientSecret,
            "grant_type": "client_credentials"
        ]
        
        sessionManager.request(
            PetfinderServiceConstants.authorizeURL,
            method: .post,
            parameters: parameters,
            headers: headers)
            .responseDecodable(of: PetfinderAccessToken.self) { response in
              guard let tokn = response.value else {
                return completion(false)
              }
              TokenManager.shared.saveAccessToken(accessToken: tokn)
              completion(true)
            }
        
    }
    
    func fetchAnimalTypes(completion: @escaping (AnimalTypes?) -> Void) {
        
        guard let curToken = TokenManager.shared.fetchAccessToken() else {
            completion(nil)
            return
        }
        
        let authHeader = "Bearer \(curToken)"
        let headers: HTTPHeaders = [
            "Authorization": authHeader
        ]
        
        sessionManager.request(
            PetfinderServiceConstants.getTypesURL,
            method: .get,
            headers: headers)
            .responseDecodable(of: AnimalTypes.self) { response in
                guard let animalTypes = response.value else {
                    return completion(nil)
                }
                completion(animalTypes)
            }
    }
    
    func fetchBreedsForAnimal(_ animal: AnimalType, completion: @escaping ([Breed]?) -> Void) {
        
        guard let curToken = TokenManager.shared.fetchAccessToken() else {
            completion(nil)
            return
        }
        
        let authHeader = "Bearer \(curToken)"
        let headers: HTTPHeaders = [
            "Authorization": authHeader
        ]
        
        sessionManager.request(
            PetfinderServiceConstants.getBreedsURLString(animal)!,
            method: .get,
            headers: headers)
            .responseDecodable(of: Breeds.self) { response in
                guard let animalBreeds = response.value else {
                    return completion(nil)
                }
                completion(animalBreeds.breeds)
            }
    }
    
    func fetchAnimalForSelectedBreed(requestModel: FetchAnimalRequestModel, completion: @escaping ([Animal]?) -> Void) {
        
        guard let curToken = TokenManager.shared.fetchAccessToken() else {
            completion(nil)
            return
        }
        
        let authHeader = "Bearer \(curToken)"
        let headers: HTTPHeaders = [
            "Authorization": authHeader
        ]
        
        let parameters = [
            "type": requestModel.animalType.name,
            "breed": requestModel.breed.name,
            "location": requestModel.location,
            "distance": requestModel.distance,
        ]
                
        sessionManager.request(
            PetfinderServiceConstants.animalsURL,
            method: .get,
            parameters: parameters,
            headers: headers)
            .responseDecodable(of: Animals.self) { response in
                if let error = response.error {
                    print("Decoding Error: \(error)")
                }
                guard let animals = response.value else {
                    return completion(nil)
                }
                completion(animals.animals)
            }
        
    }
    
}
