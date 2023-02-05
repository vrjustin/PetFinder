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
    let id: Double
    let orgId: String
    let name: String
    let description: String
    let photos: [[String:String]]
    let status: String
    let url: String
   
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case orgId = "organization_id"
        case name = "name"
        case description = "description"
        case photos = "photos"
        case status = "status"
        case url = "url"
    }
}


