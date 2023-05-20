//
//  SpeciesList.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

struct SpeciesListResponse: Codable, Equatable {
    struct Species: Codable, Equatable {
        let name: String
        let url: String
    }
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [Species]
}
