//
//  Breeds.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation

struct Breeds: Decodable {
    let breeds: [Breed]
}

struct Breed: Decodable {
    let name: String
}
