//
//  SpeciesList.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import DomainLayer
import Foundation

public struct SpeciesListResponse: Codable, Equatable {
    public struct SpeciesResponse: Codable, Equatable {
        let name: String
        let url: String
    }
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [SpeciesResponse]
}

extension SpeciesListResponse {
    func toSpeciesList() -> SpeciesList {
        SpeciesList(
            count: count,
            next: next,
            previous: previous,
            results: results.enumerated().map { index, element in
                return element.toSpecies(id: String(index + 1))
            }
        )
    }
}

extension SpeciesListResponse.SpeciesResponse {
    public func toSpecies(id: String? = nil) -> SpeciesList.Species {
        return SpeciesList.Species(
            name: name,
            url: url
        )
    }
}
