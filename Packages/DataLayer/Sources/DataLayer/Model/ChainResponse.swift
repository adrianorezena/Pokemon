//
//  ChainResponse.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public struct ChainResponse: Codable, Equatable {
    public let evolvesTo: [ChainResponse]
    public let species: SpeciesResponse
    
    public init(evolvesTo: [ChainResponse], species: SpeciesResponse) {
        self.evolvesTo = evolvesTo
        self.species = species
    }

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}
