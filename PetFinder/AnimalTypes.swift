//
//  AnimalTypes.swift
//  PetFinder
//
//  Created by Justin Maronde on 9/19/22.
//

import Foundation

struct AnimalType: Decodable {
    let name: String
    let coats: [String]
    let colors: [String]
    let genders: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case coats = "coats"
        case colors = "colors"
        case genders = "genders"
    }
}

struct AnimalTypes: Decodable {
    let types: [AnimalType]
    
    enum CodingKeys: String, CodingKey {
        case types = "types"
    }
}
