//
//  Animals.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/21/22.
//

import Foundation

struct Animals: Decodable {
    let animals: [Animal]
    
    enum CodingKeys: String, CodingKey {
        case animals = "animals"
    }
}

struct Animal: Decodable {
    let id: Int
    let orgId: String
    let url: String
   
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case orgId = "organization_id"
        case url = "url"
    }
}
